# 2026-03-07T15:02:01.253676
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

vitis.dispose()

