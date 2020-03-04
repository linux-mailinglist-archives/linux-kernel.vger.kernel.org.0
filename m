Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45282178D59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgCDJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 04:25:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38020 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgCDJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:25:29 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0249KuL6076149
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 04:25:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfknbr62m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 04:25:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Wed, 4 Mar 2020 09:25:25 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 09:25:18 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0249OINY44302696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 09:24:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 169CBAE055;
        Wed,  4 Mar 2020 09:25:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07C27AE04D;
        Wed,  4 Mar 2020 09:25:16 +0000 (GMT)
Received: from pic2.home (unknown [9.145.145.27])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 09:25:15 +0000 (GMT)
Subject: Re: [PATCH v3 19/27] powerpc/powernv/pmem: Add an IOCTL to report
 controller statistics
To:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
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
 <20200221032720.33893-20-alastair@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Wed, 4 Mar 2020 10:25:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-20-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030409-0008-0000-0000-0000035930BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030409-0009-0000-0000-00004A7A62EF
Message-Id: <6ee036c7-f4ea-4e42-faad-66a1921553ce@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/02/2020 à 04:27, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The controller can report a number of statistics that are useful
> in evaluating the performance and reliability of the card.
> 
> This patch exposes this information via an IOCTL.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/platforms/powernv/pmem/ocxl.c | 185 +++++++++++++++++++++
>   include/uapi/nvdimm/ocxl-pmem.h            |  17 ++
>   2 files changed, 202 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> index 2cabafe1fc58..009d4fd29e7d 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> @@ -758,6 +758,186 @@ static int ioctl_controller_dump_complete(struct ocxlpmem *ocxlpmem)
>   				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
>   }
>   
> +/**
> + * controller_stats_header_parse() - Parse the first 64 bits of the controller stats admin command response
> + * @ocxlpmem: the device metadata
> + * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
> + */
> +static int controller_stats_header_parse(struct ocxlpmem *ocxlpmem,
> +	u32 *length)
> +{
> +	int rc;
> +	u64 val;
> +


unexpected empty line


> +	u16 data_identifier;
> +	u32 data_length;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	data_identifier = val >> 48;
> +	data_length = val & 0xFFFFFFFF;
> +
> +	if (data_identifier != 0x4353) { // 'CS'
> +		dev_err(&ocxlpmem->dev,
> +			"Bad data identifier for controller stats, expected 'CS', got '%-.*s'\n",
> +			2, (char *)&data_identifier);



Wow, I'm clueless what that string format looks like :-)
2 arguments? Did you check the kernel string formatter does what you want?
You may consider unifying the format though, the error log patch uses a 
simpler (better?) format for a similar message.



> +		return -EINVAL;
> +	}
> +
> +	*length = data_length;
> +	return 0;
> +}
> +
> +static int ioctl_controller_stats(struct ocxlpmem *ocxlpmem,
> +				  struct ioctl_ocxl_pmem_controller_stats __user *uarg)
> +{
> +	struct ioctl_ocxl_pmem_controller_stats args;
> +	u32 length;
> +	int rc;
> +	u64 val;
> +
> +	memset(&args, '\0', sizeof(args));
> +
> +	mutex_lock(&ocxlpmem->admin_command.lock);
> +
> +	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_CONTROLLER_STATS);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +				      ocxlpmem->admin_command.request_offset + 0x08,
> +				      OCXL_LITTLE_ENDIAN, 0);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_execute(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +
> +	rc = admin_command_complete_timeout(ocxlpmem,
> +					    ADMIN_COMMAND_CONTROLLER_STATS);
> +	if (rc < 0) {
> +		dev_warn(&ocxlpmem->dev, "Controller stats timed out\n");
> +		goto out;
> +	}
> +
> +	rc = admin_response(ocxlpmem);
> +	if (rc < 0)
> +		goto out;
> +	if (rc != STATUS_SUCCESS) {
> +		warn_status(ocxlpmem,
> +			    "Unexpected status from controller stats", rc);
> +		goto out;
> +	}


All those ioctls commands follow the same pattern:
1. admin_command_request()
2. optionnaly, set some mmio registers specific to the command
3. admin_command_execute()
4. admin_command_complete_timeout()
5. admin_response()

By swapping 1 and 2, we could then factorize steps 1, 3, 4 and 5 in a 
function and simplify/shorten the code each time a command is called.

Regarding step 2 (and that's true for all similar patches), a comment 
about what the mmio tuning does would help and avoid looking up the 
spec. Looking up the spec during the review is expected, but it will 
ease reading the code 6 months from now.



> +
> +	rc = controller_stats_header_parse(ocxlpmem, &length);
> +	if (rc)
> +		goto out;
> +
> +	if (length != 0x140)
> +		warn_status(ocxlpmem,
> +			    "Unexpected length for controller stats data, expected 0x140, got 0x%x",
> +			    length);
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x08,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		goto out;
> +
> +	args.reset_count = val >> 32;
> +	args.reset_uptime = val & 0xFFFFFFFF;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x10,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		goto out;
> +
> +	args.power_on_uptime = val >> 32;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x08,
 > +				     OCXL_LITTLE_ENDIAN, &args.host_load_count);


Those offsets are hard to understand, even with the spec next to me. And 
it seems that we could harden things a bit:
each block as a "statistics parameter ID" and the length of the data for 
that block. We should check that and make sure we're reading what we expect.
For example, from the spec I'm looking (110d), I would expect the host 
load count to be at offset 0x10. It's entirely possible I'm misreading 
it though.



> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x10,
> +				     OCXL_LITTLE_ENDIAN, &args.host_store_count);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x18,
> +				     OCXL_LITTLE_ENDIAN, &args.media_read_count);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x20,
> +				     OCXL_LITTLE_ENDIAN, &args.media_write_count);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x28,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_hit_count);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x30,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_miss_count);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x38,
> +				     OCXL_LITTLE_ENDIAN, &args.media_read_latency);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x40,
> +				     OCXL_LITTLE_ENDIAN, &args.media_write_latency);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x48,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_read_latency);
> +	if (rc)
> +		goto out;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +				     ocxlpmem->admin_command.data_offset + 0x08 + 0x40 + 0x50,
> +				     OCXL_LITTLE_ENDIAN, &args.cache_write_latency);
> +	if (rc)
> +		goto out;
> +
> +	if (copy_to_user(uarg, &args, sizeof(args))) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	rc = admin_response_handled(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = 0;
> +	goto out;


That may be more of a personal habit, but that final goto disrupts the 
"good case" flow. And I think it's pretty unusual within the kernel.


> +
> +out:
> +	mutex_unlock(&ocxlpmem->admin_command.lock);
> +	return rc;
> +}
> +
>   static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
>   {
>   	struct ocxlpmem *ocxlpmem = file->private_data;
> @@ -781,6 +961,11 @@ static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
>   	case IOCTL_OCXL_PMEM_CONTROLLER_DUMP_COMPLETE:
>   		rc = ioctl_controller_dump_complete(ocxlpmem);
>   		break;
> +
> +	case IOCTL_OCXL_PMEM_CONTROLLER_STATS:
> +		rc = ioctl_controller_stats(ocxlpmem,
> +					    (struct ioctl_ocxl_pmem_controller_stats __user *)args);
> +		break;
>   	}
>   
>   	return rc;
> diff --git a/include/uapi/nvdimm/ocxl-pmem.h b/include/uapi/nvdimm/ocxl-pmem.h
> index d4d8512d03f7..add223aa2fdb 100644
> --- a/include/uapi/nvdimm/ocxl-pmem.h
> +++ b/include/uapi/nvdimm/ocxl-pmem.h
> @@ -50,6 +50,22 @@ struct ioctl_ocxl_pmem_controller_dump_data {
>   	__u64 reserved[8];
>   };
>   
> +struct ioctl_ocxl_pmem_controller_stats {
> +	__u32 reset_count;
> +	__u32 reset_uptime; /* seconds */
> +	__u32 power_on_uptime; /* seconds */


Same as before, we're going to have some padding here.

   Fred


> +	__u64 host_load_count;
> +	__u64 host_store_count;
> +	__u64 media_read_count;
> +	__u64 media_write_count;
> +	__u64 cache_hit_count;
> +	__u64 cache_miss_count;
> +	__u64 media_read_latency; /* nanoseconds */
> +	__u64 media_write_latency; /* nanoseconds */
> +	__u64 cache_read_latency; /* nanoseconds */
> +	__u64 cache_write_latency; /* nanoseconds */
> +};
> +
>   /* ioctl numbers */
>   #define OCXL_PMEM_MAGIC 0x5C
>   /* SCM devices */
> @@ -57,5 +73,6 @@ struct ioctl_ocxl_pmem_controller_dump_data {
>   #define IOCTL_OCXL_PMEM_CONTROLLER_DUMP			_IO(OCXL_PMEM_MAGIC, 0x02)
>   #define IOCTL_OCXL_PMEM_CONTROLLER_DUMP_DATA		_IOWR(OCXL_PMEM_MAGIC, 0x03, struct ioctl_ocxl_pmem_controller_dump_data)
>   #define IOCTL_OCXL_PMEM_CONTROLLER_DUMP_COMPLETE	_IO(OCXL_PMEM_MAGIC, 0x04)
> +#define IOCTL_OCXL_PMEM_CONTROLLER_STATS		_IO(OCXL_PMEM_MAGIC, 0x05)
>   
>   #endif /* _UAPI_OCXL_SCM_H */
> 

