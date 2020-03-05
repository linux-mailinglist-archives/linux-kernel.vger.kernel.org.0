Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F717A242
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 10:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEJdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 04:33:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgCEJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:33:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0259MhA5140714
        for <linux-kernel@vger.kernel.org>; Thu, 5 Mar 2020 04:33:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yjx04snnu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:33:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Thu, 5 Mar 2020 09:33:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 09:33:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0259XO8d49348610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 09:33:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21AA242049;
        Thu,  5 Mar 2020 09:33:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D2AD4204D;
        Thu,  5 Mar 2020 09:33:23 +0000 (GMT)
Received: from pic2.home (unknown [9.145.161.121])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 09:33:23 +0000 (GMT)
Subject: Re: [PATCH v3 17/27] powerpc/powernv/pmem: Implement the Read Error
 Log command
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-18-alastair@au1.ibm.com>
 <7767dec4-fb78-dd3e-3720-8d15f544639e@linux.ibm.com>
 <739066a997f83e7aa27dc364071223936fa753ef.camel@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Thu, 5 Mar 2020 10:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <739066a997f83e7aa27dc364071223936fa753ef.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030509-0008-0000-0000-000003598926
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030509-0009-0000-0000-00004A7ABFC9
Message-Id: <758b62a8-f359-504d-3d45-fa96d1ef468f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_02:2020-03-04,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=2 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +	if (rc)
>>> +		goto out;
>>> +
>>> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
>>> +				     ocxlpmem-
>>>> admin_command.data_offset + 0x28,
>>> +				     OCXL_HOST_ENDIAN, &log->wwid[1]);
>>> +	if (rc)
>>> +		goto out;
>>> +
>>> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
>>> +				     ocxlpmem-
>>>> admin_command.data_offset + 0x30,
>>> +				     OCXL_HOST_ENDIAN, (u64 *)log-
>>>> fw_revision);
>>> +	if (rc)
>>> +		goto out;
>>> +	log->fw_revision[8] = '\0';
>>> +
>>> +	buf_length = (user_buf_length < log->buf_size) ?
>>> +		     user_buf_length : log->buf_size;
>>> +	for (i = 0; i < buf_length + 0x48; i += 8) {
>>> +		u64 val;
>>> +
>>> +		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
>>> +					     ocxlpmem-
>>>> admin_command.data_offset + i,
>>> +					     OCXL_HOST_ENDIAN, &val);
>>> +		if (rc)
>>> +			goto out;
>>> +
>>> +		if (buf_is_user) {
>>> +			if (copy_to_user(&log->buf[i], &val,
>>> sizeof(u64))) {
>>> +				rc = -EFAULT;
>>> +				goto out;
>>> +			}
>>> +		} else
>>> +			log->buf[i] = val;
>>> +	}
>>
>>
>> I think it could be a bit simplified by keeping the handling of the
>> user
>> buffer out of this function. Always call it with a kernel buffer.
>> And
>> have only one copy_to_user() call on the ioctl() path. You'd need to
>> allocate a kernel buf on the ioctl path, but you're already doing it
>> on
>> the probe() path, so it should be doable to share code.
> 
> Hmm, the problem then is that on the IOCTL side, I'll have to save,
> modify, then restore the buf member of struct
> ioctl_ocxl_pmem_error_log, which would be uglier.


buf is just an output buffer. All you'd need to do is allocate a kernel 
buf, like it's already done for the "probe" case in dump_error_log(). 
And add a global copy_to_user() of the buf at the end of the ioctl path, 
instead of having multiple smaller copy_to_user() in the loop here.
copy_to_user() is a bit expensive so it's usually better to regroup 
them. I think it's easy here and make sense since that function is also 
trying to handle both a kernel and user space bufffers.
But we're not in a critical path, and after this patch, there are others 
copying out mmio content to user buffers and those don't have a kernel 
buffer to handle, so the copy_to_user() in a loop makes things easier.
So I guess the conclusion is whatever you think is the easiest...



>>
>>
>>> +
>>> +	rc = admin_response_handled(ocxlpmem);
>>> +	if (rc)
>>> +		goto out;
>>> +
>>> +out:
>>> +	mutex_unlock(&ocxlpmem->admin_command.lock);
>>> +	return rc;
>>> +
>>> +}
>>> +
>>> +static int ioctl_error_log(struct ocxlpmem *ocxlpmem,
>>> +		struct ioctl_ocxl_pmem_error_log __user *uarg)
>>> +{
>>> +	struct ioctl_ocxl_pmem_error_log args;
>>> +	int rc;
>>> +
>>> +	if (copy_from_user(&args, uarg, sizeof(args)))
>>> +		return -EFAULT;
>>> +
>>> +	rc = read_error_log(ocxlpmem, &args, true);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	if (copy_to_user(uarg, &args, sizeof(args)))
>>> +		return -EFAULT;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static long file_ioctl(struct file *file, unsigned int cmd,
>>> unsigned long args)
>>> +{
>>> +	struct ocxlpmem *ocxlpmem = file->private_data;
>>> +	int rc = -EINVAL;
>>> +
>>> +	switch (cmd) {
>>> +	case IOCTL_OCXL_PMEM_ERROR_LOG:
>>> +		rc = ioctl_error_log(ocxlpmem,
>>> +				     (struct ioctl_ocxl_pmem_error_log
>>> __user *)args);
>>> +		break;
>>> +	}
>>> +	return rc;
>>> +}
>>> +
>>>    static const struct file_operations fops = {
>>>    	.owner		= THIS_MODULE,
>>>    	.open		= file_open,
>>>    	.release	= file_release,
>>> +	.unlocked_ioctl = file_ioctl,
>>> +	.compat_ioctl   = file_ioctl,
>>>    };
>>>    
>>>    /**
>>> @@ -527,6 +736,60 @@ static int read_device_metadata(struct
>>> ocxlpmem *ocxlpmem)
>>>    	return 0;
>>>    }
>>>    
>>> +static const char *decode_error_log_type(u8 error_log_type)
>>> +{
>>> +	switch (error_log_type) {
>>> +	case 0x00:
>>> +		return "general";
>>> +	case 0x01:
>>> +		return "predictive failure";
>>> +	case 0x02:
>>> +		return "thermal warning";
>>> +	case 0x03:
>>> +		return "data loss";
>>> +	case 0x04:
>>> +		return "health & performance";
>>> +	default:
>>> +		return "unknown";
>>> +	}
>>> +}
>>> +
>>> +static void dump_error_log(struct ocxlpmem *ocxlpmem)
>>> +{
>>> +	struct ioctl_ocxl_pmem_error_log log;
>>> +	u32 buf_size;
>>> +	u8 *buf;
>>> +	int rc;
>>> +
>>> +	if (ocxlpmem->admin_command.data_size == 0)
>>> +		return;
>>> +
>>> +	buf_size = ocxlpmem->admin_command.data_size - 0x48;
>>> +	buf = kzalloc(buf_size, GFP_KERNEL);
>>> +	if (!buf)
>>> +		return;
>>> +
>>> +	log.buf = buf;
>>> +	log.buf_size = buf_size;
>>> +
>>> +	rc = read_error_log(ocxlpmem, &log, false);
>>> +	if (rc < 0)
>>> +		goto out;
>>> +
>>> +	dev_warn(&ocxlpmem->dev,
>>> +		 "OCXL PMEM Error log: WWID=0x%016llx%016llx LID=0x%x
>>> PRC=%x type=0x%x %s, Uptime=%u seconds timestamp=0x%llx\n",
>>> +		 log.wwid[0], log.wwid[1],
>>> +		 log.log_identifier, log.program_reference_code,
>>> +		 log.error_log_type,
>>> +		 decode_error_log_type(log.error_log_type),
>>> +		 log.power_on_seconds, log.timestamp);
>>> +	print_hex_dump(KERN_WARNING, "buf", DUMP_PREFIX_OFFSET, 16, 1,
>>> buf,
>>> +		       log.buf_size, false);
>>
>> dev_warn already logs a warning. Isn't KERN_DEBUG more appropriate
>> for
>> the hex dump?
>>
>>
> 
> The hex dump is associated binary data for the warning, it doesn't
> replicate the contents of the message.


My point is not about duplicating, it's about exposing an hexadecimal 
dump where it makes sense. Those DEBUG and WARNING tags are used for 
filtering content. For example to know what to display on the console. A 
warning to mention that a device hits a serious error is perfectly fine. 
A hexadecimal dump which is going to be meaningless to most everybody is 
not. The system is not crashing, so it's not like the console is our 
last hope. I think the dump is debug data and should be tagged as such.

   Fred



>>
>>> +
>>> +out:
>>> +	kfree(buf);
>>> +}
>>> +
>>>    /**
>>>     * probe_function0() - Set up function 0 for an OpenCAPI
>>> persistent memory device
>>>     * This is important as it enables templates higher than 0 across
>>> all other functions,
>>> @@ -568,6 +831,7 @@ static int probe(struct pci_dev *pdev, const
>>> struct pci_device_id *ent)
>>>    	struct ocxlpmem *ocxlpmem;
>>>    	int rc;
>>>    	u16 elapsed, timeout;
>>> +	u64 chi;
>>>    
>>>    	if (PCI_FUNC(pdev->devfn) == 0)
>>>    		return probe_function0(pdev);
>>> @@ -667,6 +931,11 @@ static int probe(struct pci_dev *pdev, const
>>> struct pci_device_id *ent)
>>>    	return 0;
>>>    
>>>    err:
>>> +	if (ocxlpmem &&
>>> +		    (ocxlpmem_chi(ocxlpmem, &chi) == 0) &&
>>> +		    (chi & GLOBAL_MMIO_CHI_ELA))
>>> +		dump_error_log(ocxlpmem);
>>> +
>>>    	/*
>>>    	 * Further cleanup is done in the release handler via
>>> free_ocxlpmem()
>>>    	 * This allows us to keep the character device live to handle
>>> IOCTLs to
>>> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
>>> b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
>>> index d2d81fec7bb1..b953ee522ed4 100644
>>> --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
>>> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
>>> @@ -5,6 +5,7 @@
>>>    #include <linux/cdev.h>
>>>    #include <misc/ocxl.h>
>>>    #include <linux/libnvdimm.h>
>>> +#include <uapi/nvdimm/ocxl-pmem.h>
>>
>> Can't we limit the extra include to ocxl.c?
>>
> 
> Yes, there are no consumers referred to in ocxl_interal.[hc]
> 
>> Completely unrelated, but ocxl.c contains most of the code for this
>> driver. We should consider renaming it to ocxlpmem.c or something
>> along
>> those lines, since it does a lot more than just interfacing with the
>> opencapi interface. And would avoid confusion with an other already
>> existing ocxl.c file.
>>
> 
> Ok, my thinking was that it's already in a pmem directory, but I can
> see arguments both ways.
> 
>>
>>>    #include <linux/mm.h>
>>>    
>>>    #define LABEL_AREA_SIZE	(1UL << PA_SECTION_SHIFT)
>>> diff --git a/include/uapi/nvdimm/ocxl-pmem.h
>>> b/include/uapi/nvdimm/ocxl-pmem.h
>>> new file mode 100644
>>> index 000000000000..b10f8ac0c20f
>>> --- /dev/null
>>> +++ b/include/uapi/nvdimm/ocxl-pmem.h
>>> @@ -0,0 +1,46 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>>> +/* Copyright 2017 IBM Corp. */
>>> +#ifndef _UAPI_OCXL_SCM_H
>>> +#define _UAPI_OCXL_SCM_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/ioctl.h>
>>> +
>>> +#define OCXL_PMEM_ERROR_LOG_ACTION_RESET	(1 << (32-32))
>>> +#define OCXL_PMEM_ERROR_LOG_ACTION_CHKFW	(1 << (53-32))
>>> +#define OCXL_PMEM_ERROR_LOG_ACTION_REPLACE	(1 << (54-32))
>>> +#define OCXL_PMEM_ERROR_LOG_ACTION_DUMP		(1 << (55-32))
>>> +
>>> +#define OCXL_PMEM_ERROR_LOG_TYPE_GENERAL		(0x00)
>>> +#define OCXL_PMEM_ERROR_LOG_TYPE_PREDICTIVE_FAILURE	(0x01)
>>> +#define OCXL_PMEM_ERROR_LOG_TYPE_THERMAL_WARNING	(0x02)
>>> +#define OCXL_PMEM_ERROR_LOG_TYPE_DATA_LOSS		(0x03)
>>> +#define OCXL_PMEM_ERROR_LOG_TYPE_HEALTH_PERFORMANCE	(0x04)
>>> +
>>> +struct ioctl_ocxl_pmem_error_log {
>>> +	__u32 log_identifier; /* out */
>>> +	__u32 program_reference_code; /* out */
>>> +	__u32 action_flags; /* out, recommended course of action */
>>> +	__u32 power_on_seconds; /* out, Number of seconds the
>>> controller has been on when the error occurred */
>>> +	__u64 timestamp; /* out, relative time since the current IPL */
>>> +	__u64 wwid[2]; /* out, the NAA formatted WWID associated with
>>> the controller */
>>> +	char  fw_revision[8+1]; /* out, firmware revision as null
>>> terminated text */
>>
>> The 8+1 size will make the compiler add some padding here. Are we
>> confident that all the compilers, at least on powerpc, will do the
>> same
>> thing and we can guarantee a kernel ABI? I would play it safe and
>> have a
>> discussion with folks who understand compilers better.
>>
> 
> I'll add some explicit padding.
> 
>>
>>
>>> +	__u16 buf_size; /* in/out, buffer size provided/required.
>>> +			 * If required is greater than provided, the
>>> buffer
>>> +			 * will be truncated to the amount provided. If
>>> its
>>> +			 * less, then only the required bytes will be
>>> populated.
>>> +			 * If it is 0, then there are no more error log
>>> entries.
>>> +			 */
>>> +	__u8  error_log_type;
>>> +	__u8  reserved1;
>>> +	__u32 reserved2;
>>> +	__u64 reserved3[2];
>>> +	__u8 *buf; /* pointer to output buffer */
>>> +};
>>> +
>>> +/* ioctl numbers */
>>> +#define OCXL_PMEM_MAGIC 0x5C
>>
>> Randomly picked?
>> See (and add entry in) Documentation/userspace-api/ioctl/ioctl-
>> number.rst
>>
> Ok
> 
>>
>>     Fred
>>
>>
>>
>>> +/* SCM devices */
>>> +#define IOCTL_OCXL_PMEM_ERROR_LOG			_IOWR(OCXL_PMEM
>>> _MAGIC, 0x01, struct ioctl_ocxl_pmem_error_log)
>>> +
>>> +#endif /* _UAPI_OCXL_SCM_H */
>>>

