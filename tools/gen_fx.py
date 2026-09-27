"""Generates the frame-by-frame effect functions in data/pocket/function/fx/.
Run from the pack root: python3 tools/gen_fx.py"""
import math, os

OUT = 'data/pocket/function/fx'
def f(v): return f'{v:.3f}'.rstrip('0').rstrip('.') if abs(v) > 1e-9 else '0'
def rel(x, y, z): return ' '.join('~' if f(v) == '0' else '~' + f(v) for v in (x, y, z))
def rgb(c): return '[' + ','.join(f(x) for x in c) + ']'

PALETTES = {
    'in':  dict(a=(0.62, 0.32, 1.0), b=(0.35, 0.9, 1.0), rune=(0.72, 0.45, 1.0), rune2=(0.4, 0.75, 1.0), flash=(0.7, 0.4, 1.0)),
    'out': dict(a=(1.0, 0.8, 0.35), b=(1.0, 1.0, 0.85), rune=(1.0, 0.75, 0.3), rune2=(1.0, 0.95, 0.7), flash=(1.0, 0.85, 0.5)),
}
CHARGE = 20      # frames of charge-up; frame CHARGE launches
ARRIVE = 16      # frames of arrival afterglow

def dust(c, s=1.0): return f'minecraft:dust{{color:{rgb(c)},scale:{f(s)}}}'
def dct(a, b, s=1.0): return f'minecraft:dust_color_transition{{from_color:{rgb(a)},to_color:{rgb(b)},scale:{f(s)}}}'

def ring(particle, r, y, n, phase=0.0, velocity=0.0, inward=False):
    """Ring of particles. With velocity > 0 each particle is fired outward (or inward)
    using the count-0 trick: dx dy dz become a direction and speed becomes its magnitude."""
    out = []
    for i in range(n):
        a = phase + 2 * math.pi * i / n
        x, z = r * math.cos(a), r * math.sin(a)
        if velocity:
            d = -1 if inward else 1
            out.append(f'particle {particle} {rel(x, y, z)} {f(d*math.cos(a))} 0 {f(d*math.sin(a))} {f(velocity)} 0')
        else:
            out.append(f'particle {particle} {rel(x, y, z)} 0 0 0 0 1')
    return out

def key_keyframe(angle, scale, dur):
    return ('execute as @e[type=minecraft:item_display,tag=pocket.fxkey,distance=..6] '
            'if score @s pocket.slot = #s pocket.tmp run data merge entity @s '
            f'{{start_interpolation:0,interpolation_duration:{dur},transformation:{{'
            f'left_rotation:{{angle:{f(angle)}f,axis:[0f,1f,0f]}},right_rotation:[0f,0f,0f,1f],'
            f'translation:[0f,0f,0f],scale:[{f(scale)}f,{f(scale)}f,{f(scale)}f]}}}}')

# Key spin schedule: frame -> (angle, scale, ticks)
KEY = {2: (1.571, 0.9, 4), 5: (3.142, 0.95, 4), 9: (4.712, 1.0, 3), 12: (6.283, 1.05, 2),
       14: (1.571, 1.15, 2), 16: (3.142, 1.25, 2), 18: (4.712, 1.3, 1), 19: (4.712, 0.0, 2)}

def charge(kind):
    p = PALETTES[kind]
    frames = {}
    for fr in range(1, CHARGE):
        L = []
        # Twin helix: rises for entering, falls for leaving. 4 sub-steps per frame keep it smooth.
        for sub in range(4):
            t = ((fr - 1) + sub / 4) / (CHARGE - 1)
            h = t if kind == 'in' else 1 - t
            y = 0.05 + 2.4 * h
            r = 1.15 - 0.5 * t
            for strand in (0, math.pi):
                a = 5 * math.pi * t + strand
                L.append(f'particle {dct(p["a"], p["b"], 0.9)} {rel(r*math.cos(a), y, r*math.sin(a))} 0 0 0 0 1')
        # Two counter-rotating rune circles on the ground
        L += ring(dust(p['rune'], 0.6), 1.55, 0.06, 16, phase=fr * 0.09)
        L += ring(dust(p['rune2'], 0.5), 0.9, 0.06, 8, phase=-fr * 0.14)
        # Enchanting glyphs and portal motes get sucked into the player
        L.append('particle minecraft:enchant ~ ~1.1 ~ 0.4 0.4 0.4 1.6 4')
        L.append('particle minecraft:portal ~ ~0.9 ~ 0.5 0.6 0.5 1.0 6')
        if fr in (6, 10, 14):
            L.append(f'function pocket:fx/streams_{kind}')
        if fr == 1:
            L.append('function pocket:fx/key_spawn')
            if kind == 'in':
                L.append('playsound minecraft:block.beacon.activate player @a ~ ~ ~ 0.7 1.7')
                L.append('playsound minecraft:block.trial_spawner.ominous_activate player @a ~ ~ ~ 0.5 1.4')
            else:
                L.append('playsound minecraft:block.vault.activate player @a ~ ~ ~ 0.8 1.2')
                L.append('playsound minecraft:block.beacon.activate player @a ~ ~ ~ 0.5 2')
        for when, pitch_in, pitch_out in ((1, 0.8, 1.5), (7, 1.1, 1.1), (13, 1.5, 0.8)):
            if fr == when:
                L.append(f'playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 0.6 {pitch_in if kind == "in" else pitch_out}')
        if fr == 10:
            L.append('playsound minecraft:block.portal.trigger player @s ~ ~ ~ 0.35 1.6')
        if fr == 12:
            L.append('posteffect add @s minecraft:blur')
        if fr == 16:
            L.append('playsound minecraft:entity.illusioner.prepare_mirror player @a ~ ~ ~ 0.6 1.3')
        if fr == 18:
            L += ring('minecraft:end_rod', 2.3, 1.0, 24, velocity=0.13, inward=True)
        if fr in KEY:
            L.append(key_keyframe(*KEY[fr]))
        frames[fr] = L
    frames[CHARGE] = [f'function pocket:fx/launch_{kind}']
    return frames

def launch_burst(kind):
    p = PALETTES[kind]
    return [
        'function pocket:fx/key_kill',
        f'particle minecraft:flash{{color:[{",".join(f(x) for x in p["flash"])},1.0]}} ~ ~1 ~ 0 0 0 0 1 force',
        'particle minecraft:reverse_portal ~ ~1 ~ 0.2 0.5 0.2 0.35 60',
        'particle minecraft:end_rod ~ ~1 ~ 0 0 0 0.22 30',
        'playsound minecraft:entity.illusioner.mirror_move player @a ~ ~ ~ 1 0.9',
        'playsound minecraft:block.amethyst_cluster.break player @a ~ ~ ~ 1 0.6',
        'playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 0.5 1.5',
    ]

def arrive(kind):
    p = PALETTES[kind]
    notes = (0.5, 0.63, 0.75, 1.0) if kind == 'in' else (1.0, 1.26, 1.5, 2.0)
    frames = {}
    for fr in range(1, ARRIVE + 1):
        L = []
        if fr == 1:
            L.append(f'particle minecraft:flash{{color:[{",".join(f(x) for x in p["flash"])},1.0]}} ~ ~1 ~ 0 0 0 0 1 force')
            L += ring('minecraft:end_rod', 0.3, 0.15, 40, velocity=0.32)
            L += ring('minecraft:reverse_portal' if kind == 'in' else 'minecraft:firework', 0.3, 0.3, 24, phase=0.13, velocity=0.2)
            for i in range(24):  # light pillar
                y = i * 0.25
                L.append(f'particle {dct(p["a"], p["b"], 1.2 - i * 0.03)} ~ ~{f(y)} ~ 0.05 0 0.05 0 2')
            if kind == 'in':
                L.append('playsound minecraft:block.conduit.activate player @a ~ ~ ~ 1 1.3')
                L.append('playsound minecraft:block.amethyst_block.resonate player @a ~ ~ ~ 1 1.2')
            else:
                L.append('playsound minecraft:block.vault.open_shutter player @a ~ ~ ~ 0.8 1.4')
                L.append('playsound minecraft:block.amethyst_block.resonate player @a ~ ~ ~ 1 1.6')
            L.append('playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 0.7 1.6')
        if fr in (1, 3, 5, 7):
            L.append(f'playsound minecraft:block.note_block.chime player @a ~ ~ ~ 0.7 {notes[(fr - 1) // 2]}')
        if fr == 4:
            L.append('stopsound @s * minecraft:block.portal.trigger')
        if fr == 5:
            L += ring(dust(p['rune'], 1.0), 0.5, 0.1, 20, velocity=0.18)
        if fr <= 10:
            L.append(f'particle minecraft:end_rod ~ ~2.8 ~ 0.8 0.2 0.8 0.01 {3 if fr < 6 else 1}')
            L.append('particle minecraft:electric_spark ~ ~1 ~ 0.6 0.8 0.6 0.05 2')
        if fr == 8:
            L.append('posteffect remove @s minecraft:blur')
        if fr == ARRIVE:
            L.append('scoreboard players set @s pocket.fxm 0')
        frames[fr] = L
    return frames

def streams(kind):
    """Energy streams: trail particles that fly from a ring around the player into their chest.
    trail needs an absolute target, so this is a macro fed the player's position."""
    p = PALETTES[kind]
    L = []
    for i in range(8):
        a = 2 * math.pi * i / 8 + (0.4 if kind == 'out' else 0)
        c = p['a'] if i % 2 else p['b']
        L.append(f'$particle minecraft:trail{{target:[$(x),$(y),$(z)],color:{rgb(c)},duration:12}} '
                 f'{rel(3*math.cos(a), 0.1, 3*math.sin(a))} 0 0 0 0 1 force')
    return L

def write(path, lines):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as fh:
        fh.write('# Generated by tools/gen_fx.py\n' + '\n'.join(lines) + '\n')

for kind in ('in', 'out'):
    for fr, L in charge(kind).items():
        write(f'{OUT}/charge_{kind}/{fr}.mcfunction', L)
    for fr, L in arrive(kind).items():
        write(f'{OUT}/arrive_{kind}/{fr}.mcfunction', L)
    write(f'{OUT}/burst_{kind}.mcfunction', launch_burst(kind))
    write(f'{OUT}/streams_{kind}_m.mcfunction', streams(kind))
    write(f'{OUT}/streams_{kind}.mcfunction', [
        'execute store result storage pocket:tmp me.x double 0.01 run data get entity @s Pos[0] 100',
        'execute store result score #y pocket.tmp run data get entity @s Pos[1] 100',
        'execute store result storage pocket:tmp me.y double 0.01 run scoreboard players add #y pocket.tmp 120',
        'execute store result storage pocket:tmp me.z double 0.01 run data get entity @s Pos[2] 100',
        f'function pocket:fx/streams_{kind}_m with storage pocket:tmp me',
    ])

# Captured mob: poof where it was, and a small ring where it lands
write(f'{OUT}/mob_leave.mcfunction', [
    'particle minecraft:flash{color:[0.7,0.4,1.0,1.0]} ~ ~0.5 ~ 0 0 0 0 1',
    'particle minecraft:reverse_portal ~ ~0.6 ~ 0.3 0.5 0.3 0.3 50',
    *ring('minecraft:end_rod', 0.2, 0.2, 16, velocity=0.2),
    'playsound minecraft:entity.illusioner.mirror_move neutral @a ~ ~ ~ 1 1.3',
    'playsound minecraft:block.amethyst_cluster.break neutral @a ~ ~ ~ 1 0.9',
])
write(f'{OUT}/mob_arrive.mcfunction', [
    'particle minecraft:reverse_portal ~ ~0.6 ~ 0.3 0.5 0.3 0.2 40',
    *ring('minecraft:end_rod', 0.2, 0.15, 16, velocity=0.18),
    'playsound minecraft:block.amethyst_block.chime neutral @a ~ ~ ~ 1 1.2',
])
print('ok')
