Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D7148CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbgAXRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 12:00:42 -0500
Received: from ms.lwn.net ([45.79.88.28]:46224 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389999AbgAXRAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:00:41 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9A4DD2D6;
        Fri, 24 Jan 2020 17:00:40 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:00:39 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     andy@infradead.org, dvhart@infradead.org, lenb@kernel.org,
        andy@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] admin guide/pm: Admin guide for Intel Uncore
 Frequency limits
Message-ID: <20200124100039.70116459@lwn.net>
In-Reply-To: <20200113040143.1419770-1-srinivas.pandruvada@linux.intel.com>
References: <20200113040143.1419770-1-srinivas.pandruvada@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020 20:01:43 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Added documentation for the attributes to control uncore frequency
> selection.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
>  - Split the documentation patch to another patch to merge via different
>     tree

Which tree did you have in mind?  PM stuff tends to go through Rafael's
tree, normally, which is fine.

>  Documentation/admin-guide/pm/intel_uncore.rst | 23 +++++++++++++++++++
>  .../admin-guide/pm/working-state.rst          |  1 +
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/intel_uncore.rst
> 
> diff --git a/Documentation/admin-guide/pm/intel_uncore.rst b/Documentation/admin-guide/pm/intel_uncore.rst
> new file mode 100644
> index 000000000000..d75be65fb16a
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/intel_uncore.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================================
> +Intel® Uncore Frequency Selection

I would really like to avoid adding ® symbols throughout the docs.  I get
grief for non-ASCII symbols that actually have a need to be there; this
isn't one of those.  

> +=========================================================
> +
> +The uncore frequency in the Intel(R) hardware is selected based on internal heuristics, which uses the current selected performance state and various system power constraints. In majority of the cases this selection is the most optimal, so there is no need for placing external constraints from the Operating System.

I would say that this violates the 80-character limit by a character or
two...  The entire patch has this problem.

> +
> +But there are some customers who wants less jitters from dynamic uncore frequency selection. For them, power saving is much lower priority than consistent performance. Currently these customers uses MSR 0x620, to place hard limits on the maximum and the minimum uncore frequency. They can now use Linux sysfs to place these limits and also have additional capability to place hard limits under power constraint scenario.

less jitter (singular)

> +
> +The Uncore frequency section attributes are present under "/sys/devices/system/cpu/intel_uncore_frequency".
> +The scope of these attributes is per die in multi-die systems or package wide in non multi-die systems. There is a unique folder for each die or package. For example:
> +"package_00_die_00" for package 0 and die 0.

This may not render as you would like; use an RST literal block here.

Thanks,

jon

