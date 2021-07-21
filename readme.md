<h1>ReadMe</h1>
<ul>
    <li><b>Build Reason</b>: DCSB landing Zone</li>
    <li><b>Build date</b>: June 2nd, 2021</li>
    <li><b>Built by</b>: <a href="mailto:Gregory.Kealey@ssc-spc.gc.ca">Gregory.Kealey@ssc-spc.gc.ca</a></li>
</ul>

<p>This repo contains IAC code which has been deployed into the enterprise tenant environment (<a href="https://portal.azure.com">163ent</a>).
In order to continue to leverage this code, you'll need to download both <a href="https://www.terraform.io/">terraform</a> and <a href="https://terragrunt.gruntwork.io/">terragrunt</a>.Terrfrom is the deployment mechanism that leverages Azure's API, and Terragrunt is a wrapper that encases the code. both executable will need to be available in the path.</p>

<p>az login example: <code>az login --service-principal --username a4577eef-d21e-46da-b2aa-d7ae382dd9eb --password KV_PASSWORD--tenant 7198d08c-c362-4703-9854-53b6f0d8fc44</code></p>

<p>There are two core folders in this repo (iaas and init) but additional folders can be added on to the root.
The init folder deploys a storage account and keyvault, while the iaas folder deploys the core plumbing for the ESLZ (Enterprise Scale Landing Zone). When adding additional folders, you can reference both the configuration variables stored in the main hcl file (./terragrunt.hcl) and the init dependencies (<code>dependency "init" {config_path = "../init"}</code>).</p>

<h2>Variables (./terragrunt.hcl)</h2>

<table>
    <thead>
        <tr>
            <td><b>Key</b></td><td>Value</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><b>sp_name</b></td><td>Service Principal Name</td>
        </tr>
        <tr>
            <td><b>sp_keyvault</b></td><td>Keyvault where ESLZ values are stored</td>
        </tr>
        <tr>
            <td><b>subscription_id</b></td><td>ESLZ subscription ID</td>
        </tr>
        <tr>
            <td><b>kv_accessgroup_id</b></td><td>Group ID for keyvault access</td>
        </tr>
        <tr>
            <td><b>env</b></td><td>Environment Prefix</td>
        </tr>
        <tr>
            <td><b>group</b></td><td>ESLZ group</td>
        </tr>
        <tr>
            <td><b>project</b></td><td>ESLZ Project Name</td>
        </tr>
        <tr>
            <td><b>user</b></td><td>User for VM</td>
        </tr>
        <tr>
            <td><b>pwd</b></td><td>Password for VM</td>
        </tr>
        <tr>
            <td><b>vnet</b></td><td>ESLZ vnet address prefix</td>
        </tr>
        <tr>
            <td><b>tof5</b></td><td>Next Hop to F5</td>
        </tr>
        <tr>
            <td><b>snet</b></td><td>snet within ESLZ vnet</td>
        </tr>
        <tr>
            <td><b>core</b></td><td>Core vnet</td>
        </tr>
        <tr>
            <td><b>tags</b></td><td>tags</td>
        </tr>
    </tbody>
</table>

