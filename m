Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B83717C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfFFKVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 06:21:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfFFKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:21:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 069DA263967
Subject: Re: [PATCH v2] platform/chrome: wilco_ec: Add version sysfs entries
To:     Nick Crews <ncrews@chromium.org>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
References: <20190603181649.143640-1-rrangel@chromium.org>
 <073e1600-18fe-84ea-03df-7b53b9b7c690@collabora.com>
 <CAHX4x8558sa8WX2n9ar94bJn6YsejqNgFFouY+3piT4jExF1DA@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <41d712b3-331f-f346-8e4a-68c358d1f295@collabora.com>
Date:   Thu, 6 Jun 2019 12:21:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHX4x8558sa8WX2n9ar94bJn6YsejqNgFFouY+3piT4jExF1DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/19 17:12, Nick Crews wrote:
> Thanks Raul and Enric, this looks good to me.
> 
> On Mon, Jun 3, 2019 at 2:40 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Nick,
>>
>> On 3/6/19 20:16, Raul E Rangel wrote:
>>> Add the ability to extract version information from the EC.
>>>
>>> Example Output:
>>> $ cd /sys/bus/platform/devices/GOOG000C:00
>>> $ tail build_date build_revision version model_number
>>> ==> build_date <==
>>> 04/25/19
>>>
>>> ==> build_revision <==
>>> d2592cae0
>>>
>>> ==> version <==
>>> 00.00.14
>>>
>>> ==> model_number <==
>>> 08B6
>>>
>>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> 
> Reviewed-by: Nick Crews <ncrews@chromium.org>

applied for 5.3

Thanks,
 Enric

> 
>>
>> Can I get your rb here?
>>
>> Thanks,
>>  Enric
>>
>>> ---
>>> This patch is rebased on chromeos-platform/for-next. It was originally
>>> developed on the chromiumos 4.19 kernel which has the following patch
>>> applied: https://lore.kernel.org/patchwork/patch/1062995/. That patch is
>>> not currently upstream.
>>>
>>> Changes in v2:
>>> - Removed version directory
>>> - Renamed label to version
>>> - Sorted documentation
>>>
>>>  .../ABI/testing/sysfs-platform-wilco-ec       | 31 ++++++++
>>>  drivers/platform/chrome/wilco_ec/sysfs.c      | 79 +++++++++++++++++++
>>>  2 files changed, 110 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
>>> index 8e5d6eee44db2..8827a734f9331 100644
>>> --- a/Documentation/ABI/testing/sysfs-platform-wilco-ec
>>> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
>>> @@ -7,3 +7,34 @@ Description:
>>>               want to run their device headless or with a dock.
>>>
>>>               Input should be parseable by kstrtou8() to 0 or 1.
>>> +
>>> +What:          /sys/bus/platform/devices/GOOG000C\:00/build_date
>>> +Date:          May 2019
>>> +KernelVersion: 5.3
>>> +Description:
>>> +               Display Wilco Embedded Controller firmware build date.
>>> +               Output will a MM/DD/YY string.
>>> +
>>> +What:          /sys/bus/platform/devices/GOOG000C\:00/build_revision
>>> +Date:          May 2019
>>> +KernelVersion: 5.3
>>> +Description:
>>> +               Display Wilco Embedded Controller build revision.
>>> +               Output will a version string be similar to the example below:
>>> +               d2592cae0
>>> +
>>> +What:          /sys/bus/platform/devices/GOOG000C\:00/model_number
>>> +Date:          May 2019
>>> +KernelVersion: 5.3
>>> +Description:
>>> +               Display Wilco Embedded Controller model number.
>>> +               Output will a version string be similar to the example below:
>>> +               08B6
>>> +
>>> +What:          /sys/bus/platform/devices/GOOG000C\:00/version
>>> +Date:          May 2019
>>> +KernelVersion: 5.3
>>> +Description:
>>> +               Display Wilco Embedded Controller firmware version.
>>> +               The format of the string is x.y.z. Where x is major, y is minor
>>> +               and z is the build number. For example: 95.00.06
>>> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
>>> index f84f0480460ae..3b86a21005d3e 100644
>>> --- a/drivers/platform/chrome/wilco_ec/sysfs.c
>>> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
>>> @@ -23,6 +23,25 @@ struct boot_on_ac_request {
>>>       u8 reserved7;
>>>  } __packed;
>>>
>>> +#define CMD_EC_INFO                  0x38
>>> +enum get_ec_info_op {
>>> +     CMD_GET_EC_LABEL        = 0,
>>> +     CMD_GET_EC_REV          = 1,
>>> +     CMD_GET_EC_MODEL        = 2,
>>> +     CMD_GET_EC_BUILD_DATE   = 3,
>>> +};
>>> +
>>> +struct get_ec_info_req {
>>> +     u8 cmd;                 /* Always CMD_EC_INFO */
>>> +     u8 reserved;
>>> +     u8 op;                  /* One of enum get_ec_info_op */
>>> +} __packed;
>>> +
>>> +struct get_ec_info_resp {
>>> +     u8 reserved[2];
>>> +     char value[9]; /* __nonstring: might not be null terminated */
>>> +} __packed;
>>> +
>>>  static ssize_t boot_on_ac_store(struct device *dev,
>>>                               struct device_attribute *attr,
>>>                               const char *buf, size_t count)
>>> @@ -57,8 +76,68 @@ static ssize_t boot_on_ac_store(struct device *dev,
>>>
>>>  static DEVICE_ATTR_WO(boot_on_ac);
>>>
>>> +static ssize_t get_info(struct device *dev, char *buf, enum get_ec_info_op op)
>>> +{
>>> +     struct wilco_ec_device *ec = dev_get_drvdata(dev);
>>> +     struct get_ec_info_req req = { .cmd = CMD_EC_INFO, .op = op };
>>> +     struct get_ec_info_resp resp;
>>> +     int ret;
>>> +
>>> +     struct wilco_ec_message msg = {
>>> +             .type = WILCO_EC_MSG_LEGACY,
>>> +             .request_data = &req,
>>> +             .request_size = sizeof(req),
>>> +             .response_data = &resp,
>>> +             .response_size = sizeof(resp),
>>> +     };
>>> +
>>> +     ret = wilco_ec_mailbox(ec, &msg);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     return scnprintf(buf, PAGE_SIZE, "%.*s\n", (int)sizeof(resp.value),
>>> +                      (char *)&resp.value);
>>> +}
>>> +
>>> +static ssize_t version_show(struct device *dev, struct device_attribute *attr,
>>> +                       char *buf)
>>> +{
>>> +     return get_info(dev, buf, CMD_GET_EC_LABEL);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(version);
>>> +
>>> +static ssize_t build_revision_show(struct device *dev,
>>> +                                struct device_attribute *attr, char *buf)
>>> +{
>>> +     return get_info(dev, buf, CMD_GET_EC_REV);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(build_revision);
>>> +
>>> +static ssize_t build_date_show(struct device *dev,
>>> +                            struct device_attribute *attr, char *buf)
>>> +{
>>> +     return get_info(dev, buf, CMD_GET_EC_BUILD_DATE);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(build_date);
>>> +
>>> +static ssize_t model_number_show(struct device *dev,
>>> +                              struct device_attribute *attr, char *buf)
>>> +{
>>> +     return get_info(dev, buf, CMD_GET_EC_MODEL);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(model_number);
>>> +
>>> +
>>>  static struct attribute *wilco_dev_attrs[] = {
>>>       &dev_attr_boot_on_ac.attr,
>>> +     &dev_attr_build_date.attr,
>>> +     &dev_attr_build_revision.attr,
>>> +     &dev_attr_model_number.attr,
>>> +     &dev_attr_version.attr,
>>>       NULL,
>>>  };
>>>
>>>
