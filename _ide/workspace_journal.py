# 2026-05-11T19:32:32.439036900
import vitis

client = vitis.create_client()
client.set_workspace(path="C:/fpp")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="SYNTHESIS")

comp.run(operation="PACKAGE")

comp.run(operation="IMPLEMENTATION")

