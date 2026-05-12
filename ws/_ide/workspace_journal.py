# 2026-05-11T19:12:08.071345300
import vitis

client = vitis.create_client()
client.set_workspace(path="ws")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="PACKAGE")

comp.run(operation="IMPLEMENTATION")

