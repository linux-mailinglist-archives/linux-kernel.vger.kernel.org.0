Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB7A4ADC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfIARZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 13:25:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39672 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfIARZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:25:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7EBC5817A5; Sun,  1 Sep 2019 19:25:34 +0200 (CEST)
Date:   Sun, 1 Sep 2019 19:25:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH] Parallel microcode update in Linux
Message-ID: <20190901172547.GD1047@bug>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +       u64 p0, p1;
>         int ret;
> 
>         atomic_set(&late_cpus_in,  0);
>         atomic_set(&late_cpus_out, 0);
> 
> +       p0 = rdtsc_ordered();
> +
>         ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
> +
> +       p1 = rdtsc_ordered();
> +
>         if (ret > 0)
>                 microcode_check();
> 
>         pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
> 
> +       pr_info("p0: %lld, p1: %lld, diff: %lld\n", p0, p1, p1 - p0);
> +
>         return ret;
>  }
> 
> We have used a machine with a broken microcode in BIOS and no microcode in
> initramfs (to bypass early loading).
> 
> Here are the results for parallel loading (we made two measurements):

> [   18.197760] microcode: updated to revision 0x200005e, date = 2019-04-02
> [   18.201225] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
> [   18.201230] microcode: Reload completed, microcode revision: 0x200005e
> [   18.201232] microcode: p0: 118138123843052, p1: 118138153732656, diff: 29889604

> Here are the results of serial loading:
> 
> [   17.542518] microcode: updated to revision 0x200005e, date = 2019-04-02
> [   17.898365] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
> [   17.898370] microcode: Reload completed, microcode revision: 0x200005e
> [   17.898372] microcode: p0: 149220216047388, p1: 149221058945422, diff: 842898034
> 
> One can see that the difference is an order magnitude.

Well, that's impressive, but it seems to finish 300 msec later? Where does that difference
come from / how much real time do you gain by this?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
