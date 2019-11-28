Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10F710C44C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 08:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfK1HXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 02:23:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1HXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:23:46 -0500
Received: from zn.tnic (p200300EC2F0E0600C0A501A20B66F321.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:600:c0a5:1a2:b66:f321])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F26E1EC0C0A;
        Thu, 28 Nov 2019 08:23:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574925825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6GazVN7NbJY9OjKlj1ljo4/MqSScODOcwJ8iXBvFzYo=;
        b=rIXbAR5x9zTR8afmq07SSZmUw4snl5rLt/Uh7TLXqEVNiB0U72iwJUF/mE2q2sE5LMFIKV
        Dx22YZJY5SHstHhwEACHl04M3lgT+khfYV4zftWiW1272upq7C8vDAR2hMPu1r0cR9/6CQ
        3IDhxVGYONU+LyXKY5OggbXjNdlVjIo=
Date:   Thu, 28 Nov 2019 08:23:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Andre Przywara <Andre.Przywara@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v8 01/13] selftests/resctrl: Add README for resctrl tests
Message-ID: <20191128072338.GA17745@zn.tnic>
References: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
 <1574901584-212957-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1574901584-212957-2-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 04:39:32PM -0800, Fenghua Yu wrote:
> resctrl tests will be implemented. README is added for the tool first.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

What does this SOB chain mean?

Same question for patches 2,3,4,5,6,7,8,9,13.

So it seems you wanna say that Babu has contributed somehow but it is
not clear what/how.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
