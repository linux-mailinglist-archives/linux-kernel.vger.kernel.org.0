Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C447911CAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfLLKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 05:32:43 -0500
Received: from foss.arm.com ([217.140.110.172]:41590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfLLKcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:32:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5204328;
        Thu, 12 Dec 2019 02:32:41 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA63E3F6CF;
        Thu, 12 Dec 2019 02:32:39 -0800 (PST)
Subject: Re: [RESEND PATCH v5 5/5] Documentation/vmcoreinfo: Add documentation
 for 'TCR_EL1.T1SZ'
To:     Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <8a982138-f1fa-34e8-18fd-49a79cea3652@arm.com>
Date:   Thu, 12 Dec 2019 10:32:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 29/11/2019 19:59, Bhupesh Sharma wrote:
> Add documentation for TCR_EL1.T1SZ variable being added to
> vmcoreinfo.
> 
> It indicates the size offset of the memory region addressed by TTBR1_EL1

> and hence can be used for determining the vabits_actual value.

used for determining random-internal-kernel-variable, that might not exist tomorrow.

Could you describe how this is useful/necessary if a debugger wants to walk the page
tables from the core file? I think this is a better argument.

Wouldn't the documentation be better as part of the patch that adds the export?
(... unless these have to go via different trees? ..)


> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 447b64314f56..f9349f9d3345 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -398,6 +398,12 @@ KERNELOFFSET
>  The kernel randomization offset. Used to compute the page offset. If
>  KASLR is disabled, this value is zero.
>  
> +TCR_EL1.T1SZ
> +------------
> +
> +Indicates the size offset of the memory region addressed by TTBR1_EL1

> +and hence can be used for determining the vabits_actual value.

'vabits_actual' may not exist when the next person comes to read this documentation (its
going to rot really quickly).

I think the first half of this text is enough to say what this is for. You should include
words to the effect that its the hardware value that goes with swapper_pg_dir. You may
want to point readers to the arm-arm for more details on what the value means.


Thanks,

James
