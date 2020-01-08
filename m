Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52B133872
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 02:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHB2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 20:28:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:33604 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgAHB2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:28:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 17:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="246195130"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jan 2020 17:28:50 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/vt-d: skip invalid RMRR entries
To:     Barret Rhoden <brho@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
References: <20200107191610.178185-1-brho@google.com>
 <20200107191610.178185-3-brho@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bc129b51-73d3-3ed0-93a5-07df6566d535@linux.intel.com>
Date:   Wed, 8 Jan 2020 09:27:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107191610.178185-3-brho@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/8/20 3:16 AM, Barret Rhoden via iommu wrote:
> The VT-d docs specify requirements for the RMRR entries base and end
> (called 'Limit' in the docs) addresses.
> 
> This commit will cause the DMAR processing to skip any RMRR entries that
> do not meet these requirements and mark the firmware as tainted, since
> the firmware is giving us junk.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>   drivers/iommu/intel-iommu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a8bb458845bc..32c3c6338a3d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4315,13 +4315,25 @@ static void __init init_iommu_pm_ops(void)
>   static inline void init_iommu_pm_ops(void) {}
>   #endif	/* CONFIG_PM */
>   
> +static int rmrr_validity_check(struct acpi_dmar_reserved_memory *rmrr)
> +{
> +	if ((rmrr->base_address & PAGE_MASK) ||
> +	    (rmrr->end_address <= rmrr->base_address) ||
> +	    ((rmrr->end_address - rmrr->base_address + 1) & PAGE_MASK)) {
> +		pr_err(FW_BUG "Broken RMRR base: %#018Lx end: %#018Lx\n",
> +		       rmrr->base_address, rmrr->end_address);

Since you will WARN_TAINT below, do you still want an error message
here?

> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>   {
>   	struct acpi_dmar_reserved_memory *rmrr;
>   	struct dmar_rmrr_unit *rmrru;
>   
>   	rmrr = (struct acpi_dmar_reserved_memory *)header;
> -	if (arch_rmrr_sanity_check(rmrr)) {
> +	if (rmrr_validity_check(rmrr) || arch_rmrr_sanity_check(rmrr)) {
>   		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
>   			   "Your BIOS is broken; bad RMRR [%#018Lx-%#018Lx]\n"
>   			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
> 

Best regards,
baolu
