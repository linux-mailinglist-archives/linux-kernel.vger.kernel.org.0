Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20A615CB54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgBMTp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 14:45:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgBMTp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:45:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DJPRhv113119;
        Thu, 13 Feb 2020 14:45:52 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y57dd5xwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 14:45:51 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DJeIt4028332;
        Thu, 13 Feb 2020 19:45:50 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2y5bbygm22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 19:45:50 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DJjoQG54067640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:45:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B2D4B2065;
        Thu, 13 Feb 2020 19:45:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F054EB2064;
        Thu, 13 Feb 2020 19:45:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 19:45:49 +0000 (GMT)
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        gcwilson@linux.ibm.com
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
 <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
 <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
 <20200213183508.GL31668@ziepe.ca>
 <b424faea-33a7-8e5a-caac-f322fad68118@linux.ibm.com>
 <20200213191108.GO31668@ziepe.ca>
 <1e301947-a8f3-0b7d-d86c-5bfe04a68a75@linux.ibm.com>
 <20200213193908.GP31668@ziepe.ca>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8406ff6d-c24f-0815-25f8-fa9a97dcde8b@linux.ibm.com>
Date:   Thu, 13 Feb 2020 14:45:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200213193908.GP31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_07:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 2:39 PM, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2020 at 02:15:03PM -0500, Stefan Berger wrote:
>> On 2/13/20 2:11 PM, Jason Gunthorpe wrote:
>>> On Thu, Feb 13, 2020 at 02:04:12PM -0500, Stefan Berger wrote:
>>>> On 2/13/20 1:35 PM, Jason Gunthorpe wrote:
>>>>> On Thu, Feb 13, 2020 at 01:20:12PM -0500, Stefan Berger wrote:
>>>>>
>>>>>> I don't want side effects for the TPM 1.2 case here, so I am only modifying
>>>>>> the flag for the case where the new TPM 2 is being used.  Here's the code
>>>>>> where it shows the effect.
>>>>> I'm surprised this driver is using AUTO_STARTUP, it was intended for
>>>>> embedded cases where their is no firmware to boot the TPM.
>>>> The TIS is also using it on any device.
>>> TIS is a generic driver, and can run on TPMs without firmware
>>> support. It doesn't know either way
>> The following drivers are all using it:
>>
>>
>> drivers/char/tpm/st33zp24/st33zp24.c, line 493
>> drivers/char/tpm/tpm-interface.c, line 374
>> drivers/char/tpm/tpm_crb.c, line 421
>> drivers/char/tpm/tpm_ftpm_tee.c, line 184
>> drivers/char/tpm/tpm_i2c_atmel.c, line 139
>> drivers/char/tpm/tpm_i2c_infineon.c, line 602
>> drivers/char/tpm/tpm_i2c_nuvoton.c, line 465
>> drivers/char/tpm/tpm_tis_core.c, line 917
>> drivers/char/tpm/tpm_vtpm_proxy.c, line 435
>>
>> https://elixir.bootlin.com/linux/latest/ident/TPM_OPS_AUTO_STARTUP
> These are all general purpose drivers.
>
> Though perhaps vtpm_proxy shouldn't include it, not sure.
>
>>>>> Chips using AUTO_STARTUP are basically useless for PCRs/etc.
>>>>>
>>>>> I'd expect somthing called vtpm to have been started and PCRs working
>>>>> before Linux is started??
>>>> Yes, there's supposed to be firmware.
>>>>
>>>> I only see one caller to tpm2_get_cc_attrs_tbl(chip), which is necessary to
>>>> call. This caller happens to be in tpm2_auto_startup.
>>> That seems to be a mistake, proper startup of the driver should never
>>> require auto_startup.
>> Is this IBM vTPM driver special that it should do things differently than
>> all those drivers listed above? From looking at the code is seems it is to
>> be set for the TPM 2.0 case.
> Any driver that knows the TPM must be started prior to Linux
> booting should not use the flag.  vtpm drivers in general would seem
> to be the case where we can make this statement.

Wouldn't this statement apply to all systems, including embedded ones?  
Basically all firmwares should implement the CRTM and do the TPM 
initialization.


>
> If it was mandatory then it would not be a flag the driver has to specify.

I'll add a case where we call into  tpm2_get_cc_attrs_tbl(chip) in case 
the auto startup flag is not set. I believe this is the only part that's 
missing for TPM 2 to work if not autostarted.


    Stefan


>
> Jason


