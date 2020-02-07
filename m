Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CF155C54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 18:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGRA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 12:00:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:00:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0D1D6295DF1
Subject: Re: [PATCH 1/3] platform/chrome: Add Type C connector class driver
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        heikki.krogerus@intel.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200205205954.84503-1-pmalani@chromium.org>
 <20200205205954.84503-2-pmalani@chromium.org>
 <544d31cc-e840-c91e-f65d-7f7b57ba1337@collabora.corp-partner.google.com>
 <CACeCKacvCf-PzpgzC=_v9yEwiaciqxdAOGC0GG8SfDW5hKN9+w@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9f3a8777-9bd4-5044-7d3b-5ccf25a9b97e@collabora.com>
Date:   Fri, 7 Feb 2020 18:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CACeCKacvCf-PzpgzC=_v9yEwiaciqxdAOGC0GG8SfDW5hKN9+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 7/2/20 0:30, Prashant Malani wrote:
> Hi Enric,
> 
> Thanks for taking a look at the patch. Please see my responses inline
> (I will defer sending the next version till the one pending question I
> had is resolved):
> 
> On Thu, Feb 6, 2020 at 8:19 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.corp-partner.google.com> wrote:
>>
>> Hi Prashant,
>>
>> On 5/2/20 21:59, Prashant Malani wrote:
>>> Add a driver to implement the Type C connector class for Chrome OS
>>> devices with ECs (Embedded Controllers).
>>>
>>> The driver relies on firmware device specifications for various port
>>> attributes. On ACPI platforms, this is specified using the logical
>>> device with HID GOOG0014. On DT platforms, this is specified using the
>>> DT node with compatible string "google,cros-ec-typec".
>>>
>>
>> If that's the case you should document this in a binding file.
> 
> Done. I will add this in the next version of the series.
> 
>> driver a replacement of the cros-ec-extcon driver or is a different thing?
> 
> Currently it is distinct. We're hoping to plug in to type C connector
> class work which Heikki is working on (relating to Type C Mux agent).
> Hopefully, we will gradually transition the extcon functionality to
> the Type C port driver.
> 
>>
>> There is a device where I can test this?
> 
> I think you can try it on kevin if you add the DT node for it (haven't
> tried it myself on kevin). An example will be present in the DT
> Documentation I provide in the next version.
> 
>>
>>> This patch reads the device FW node and uses the port attributes to
>>> register the typec ports with the Type C connector class framework, but
>>> doesn't do much else.
>>>
>>> Subsequent patches will add more functionality to the driver, including
>>> obtaining current port information (polarity, vconn role, current power
>>> role etc.) after querying the EC.
>>>
>>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>>> ---
>>>  drivers/platform/chrome/Kconfig         |  11 ++
>>>  drivers/platform/chrome/Makefile        |   1 +
>>>  drivers/platform/chrome/cros_ec_typec.c | 228 ++++++++++++++++++++++++
>>>  3 files changed, 240 insertions(+)
>>>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
>>>
>>> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
>>> index 5f57282a28da00..1370dfd1ca1565 100644
>>> --- a/drivers/platform/chrome/Kconfig
>>> +++ b/drivers/platform/chrome/Kconfig
>>> @@ -214,6 +214,17 @@ config CROS_EC_SYSFS
>>>         To compile this driver as a module, choose M here: the
>>>         module will be called cros_ec_sysfs.
>>>
>>> +config CROS_EC_TYPEC
>>> +     tristate "ChromeOS EC Type-C Connector Control"
>>> +     depends on MFD_CROS_EC_DEV && TYPEC
>>> +     default n
>>
>> Default value is already n, so you don't need to put it here. But I'd say that
>> we might be interested on have default MFD_CROS_EC_DEV like the other drivers.
> 
> Done.
> 
>>
>>> +     help
>>> +       If you say Y here, you get support for accessing Type C connector
>>> +       information from the Chrome OS EC.
>>> +
>>> +       To compile this driver as a module, choose M here: the module will be
>>> +       called cros_ec_typec.
>>> +
>>>  config CROS_USBPD_LOGGER
>>>       tristate "Logging driver for USB PD charger"
>>>       depends on CHARGER_CROS_USBPD
>>> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
>>> index aacd5920d8a180..caf2a9cdb5e6d1 100644
>>> --- a/drivers/platform/chrome/Makefile
>>> +++ b/drivers/platform/chrome/Makefile
>>> @@ -12,6 +12,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)         += cros_ec_ishtp.o
>>>  obj-$(CONFIG_CROS_EC_RPMSG)          += cros_ec_rpmsg.o
>>>  obj-$(CONFIG_CROS_EC_SPI)            += cros_ec_spi.o
>>>  cros_ec_lpcs-objs                    := cros_ec_lpc.o cros_ec_lpc_mec.o
>>> +obj-$(CONFIG_CROS_EC_TYPEC)          += cros_ec_typec.o
>>>  obj-$(CONFIG_CROS_EC_LPC)            += cros_ec_lpcs.o
>>>  obj-$(CONFIG_CROS_EC_PROTO)          += cros_ec_proto.o cros_ec_trace.o
>>>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT) += cros_kbd_led_backlight.o
>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>>> new file mode 100644
>>> index 00000000000000..fe5659171c2a85
>>> --- /dev/null
>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>>> @@ -0,0 +1,228 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright 2020 Google LLC
>>> + *
>>> + * This driver provides the ability to view and manage Type C ports through the
>>> + * Chrome OS EC.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_data/cros_ec_commands.h>
>>> +#include <linux/platform_data/cros_ec_proto.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/usb/typec.h>
>>> +
>>> +#define DRV_NAME "cros-ec-typec"
>>> +
>>> +/* Platform-specific data for the Chrome OS EC Type C controller. */
>>> +struct cros_typec_data {
>>> +     struct device *dev;
>>> +     struct cros_ec_device *ec;
>>> +     int num_ports;
>>> +     /* Array of ports, indexed by port number. */
>>> +     struct typec_port *ports[EC_USB_PD_MAX_PORTS];
>>> +};
>>> +
>>> +int cros_typec_parse_port_props(struct typec_capability *cap,
>>
>> static int
> 
> Sorry, done.
> 
>>
>>> +                             struct fwnode_handle *fwnode,
>>> +                             struct device *dev)
>>> +{
>>> +     const char *buf;
>>> +     int ret;
>>> +
>>> +     memset(cap, 0, sizeof(*cap));
>>> +     ret = fwnode_property_read_string(fwnode, "power-role", &buf);
>>> +     if (ret) {
>>> +             dev_err(dev, "power-role not found: %d\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = typec_find_port_power_role(buf);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     cap->type = ret;
>>> +
>>> +     ret = fwnode_property_read_string(fwnode, "data-role", &buf);
>>> +     if (ret) {
>>> +             dev_err(dev, "data-role not found: %d\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = typec_find_port_data_role(buf);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     cap->data = ret;
>>> +
>>> +     ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
>>> +     if (ret) {
>>> +             dev_err(dev, "try-power-role not found: %d\n", ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = typec_find_power_role(buf);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     cap->prefer_role = ret;
>>> +
>>> +     cap->fwnode = fwnode;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int cros_typec_init_ports(struct cros_typec_data *typec)
>>> +{
>>> +     struct device *dev = typec->dev;
>>> +     struct typec_capability cap;
>>> +     struct fwnode_handle *fwnode;
>>> +     int ret;
>>> +     int i;
>>> +     int nports;
>>> +     u32 port_num;
>>> +
>>> +     nports = device_get_child_node_count(dev);
>>> +     if (nports == 0) {
>>> +             dev_err(dev, "No port entries found.\n");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     device_for_each_child_node(dev, fwnode) {
>>> +             if (fwnode_property_read_u32(fwnode, "port-number",
>>> +                                          &port_num)) {
>>> +                     dev_err(dev, "No port-number for port, skipping.\n");
>>> +                     ret = -EINVAL;
>>> +                     goto unregister_ports;
>>> +             }
>>> +
>>> +             if (port_num >= typec->num_ports) {
>>> +                     dev_err(dev, "Invalid port number.\n");
>>> +                     ret = -EINVAL;
>>> +                     goto unregister_ports;
>>> +             }
>>> +
>>> +             dev_dbg(dev, "Registering port %d\n", port_num);
>>> +             ret = cros_typec_parse_port_props(&cap, fwnode, dev);
>>> +             if (ret < 0)
>>> +                     goto unregister_ports;
>>> +             typec->ports[port_num] = typec_register_port(dev, &cap);
>>> +             if (IS_ERR(typec->ports[port_num])) {
>>> +                     dev_err(dev, "Failed to register port %d\n", port_num);
>>> +                     ret = PTR_ERR(typec->ports[port_num]);
>>> +                     goto unregister_ports;
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +
>>> +unregister_ports:
>>> +     for (i = 0; i < typec->num_ports; i++)
>>> +             typec_unregister_port(typec->ports[i]);
>>> +     return ret;
>>> +}
>>> +
>>> +static int cros_typec_ec_command(struct cros_typec_data *typec,
>>> +                              unsigned int version,
>>> +                              unsigned int command,
>>> +                              void *outdata,
>>> +                              unsigned int outsize,
>>> +                              void *indata,
>>> +                              unsigned int insize)
>>> +{
>>> +     struct cros_ec_command *msg;
>>> +     int ret;
>>> +
>>> +     msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
>>> +     if (!msg)
>>> +             return -ENOMEM;
>>> +
>>> +     msg->version = version;
>>> +     msg->command = command;
>>> +     msg->outsize = outsize;
>>> +     msg->insize = insize;
>>> +
>>> +     if (outsize)
>>> +             memcpy(msg->data, outdata, outsize);
>>> +
>>> +     ret = cros_ec_cmd_xfer_status(typec->ec, msg);
>>> +     if (ret >= 0 && insize)
>>> +             memcpy(indata, msg->data, insize);
>>> +
>>> +     kfree(msg);
>>> +     return ret;
>>> +}
>>> +
>>> +
>>> +static int cros_typec_get_num_ports(struct cros_typec_data *typec)
>>> +{
>>
>> This functions is only called once at probe, you can just put the code there. I
>> had some readibility problems trying to follow de code.
> 
> Done.
> 
>>
>>> +     struct ec_response_usb_pd_ports resp;
>>> +     int ret;
>>> +
>>> +     ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>>> +                                 &resp, sizeof(resp));
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     typec->num_ports = resp.num_ports;
>>> +     if (typec->num_ports > EC_USB_PD_MAX_PORTS) {
>>> +             dev_warn(typec->dev,
>>> +                      "Too many ports reported: %d, limiting to max: %d\n",
>>> +                      typec->num_ports, EC_USB_PD_MAX_PORTS);
>>
>> You say that you are limiting the number of ports to max but typec->num_ports is
>> still resp.num_ports, is that correct?
>>
> 
> Sorry, thanks for catching this, it should be set to
> EC_USB_PD_MAX_PORTS. I will fix this in the next version.
> 
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id cros_typec_acpi_id[] = {
>>> +     { "GOOG0014", 0 },
>>> +     { /* sentinel */ }
>>
>> No need to add /* sentinel */ here, is obvious.
> 
> Done.
> 
>>
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, cros_typec_acpi_id);
>>> +#endif
>>> +
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id cros_typec_of_match[] = {
>>> +     { .compatible = "google,cros-ec-typec", },
>>> +     { /* sentinel */ },
>>
>> No need to add /* sentinel */ here, is obvious. And no need for the colon at the
>> end.
> 
> Done.
>>
>>> +};
>>> +MODULE_DEVICE_TABLE(of, cros_typec_of_match);
>>> +#endif
>>> +
>>> +static int cros_typec_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct cros_typec_data *typec;
>>> +     int ret;
>>> +
>>> +     typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
>>> +     if (!typec)
>>> +             return -ENOMEM;
>>> +     typec->dev = dev;
>>> +     typec->ec = dev_get_drvdata(pdev->dev.parent);
>>> +     platform_set_drvdata(pdev, typec);
>>> +
>>> +     ret = cros_typec_get_num_ports(typec);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     ret = cros_typec_init_ports(typec);
>>
>> both, cros_typec_get_num_ports and cros_typec_init_ports are only called once,
>> as I said I had some problems of readibility because typec->num_ports is set in
>> one function and unregister in another function when fails.
> 
> Can we keep cros_typec_init_ports() as a separate function? I was
> hoping to avoid cluttering the _probe() with FW node parsing logic.
> cros_typec_init_ports() registers the ports (and unregisters on
> failure), so seems fairly self-contained.
> Of course, happy to place everything in probe if you still prefer that.
> 

I don't mind clutter probe if is more readable but try it, and lets see how
looks like. You are also registering and unregistering the typec ports there,
not only parsing. Usually what we have is parsing the firmware or dt and then
register and unregister the typec ports, all mixed. I'm more in favour of have
it separated, IMHO.

>>
>> I'd just remove those two functions and put the code directly here.
>>
>>> +     if (!ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static struct platform_driver cros_typec_driver = {
>>> +     .driver = {
>>> +             .name   = DRV_NAME,
>>
>> no tab, just space after .-name
> 
> Done.
>>
>>> +             .acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
>>> +             .of_match_table = of_match_ptr(cros_typec_of_match),
>>> +     },
>>> +     .probe          = cros_typec_probe,
>>
>> no tab, just space after .probe
> 
> Done.
> 
>>
>>> +};
>>> +
>>> +module_platform_driver(cros_typec_driver);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("Chrome OS EC Type C control");
>>>
>>
>> You probably want to add the MODULE_AUTHOR here
> 
> Done.
> 
> Best regards,
> 
