Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B52F34D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbfKGQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:42:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:35350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730364AbfKGQmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:42:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2760AE6F;
        Thu,  7 Nov 2019 16:42:49 +0000 (UTC)
Date:   Thu, 7 Nov 2019 17:42:48 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/fadump: Remove duplicate message.
Message-ID: <20191107164248.GZ1384@kitsune.suse.cz>
References: <20190923075406.5854-1-msuchanek@suse.de>
 <20191023175651.24833-1-msuchanek@suse.de>
 <aa26db2d-48b5-5825-81ab-12ca491a9971@linux.ibm.com>
 <20191024111651.GL938@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024111651.GL938@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 01:16:51PM +0200, Michal Such�nek wrote:
> On Thu, Oct 24, 2019 at 04:08:08PM +0530, Hari Bathini wrote:
> > 
> > Michal, thanks for looking into this.
> > 
> > On 23/10/19 11:26 PM, Michal Suchanek wrote:
> > > There is duplicate message about lack of support by firmware in
> > > fadump_reserve_mem and setup_fadump. Due to different capitalization it
> > > is clear that the one in setup_fadump is shown on boot. Remove the
> > > duplicate that is not shown.
> > 
> > Actually, the message in fadump_reserve_mem() is logged. fadump_reserve_mem()
> > executes first and sets fw_dump.fadump_enabled to `0`, if fadump is not supported.
> > So, the other message in setup_fadump() doesn't get logged anymore with recent
> > changes. The right thing to do would be to remove similar message in setup_fadump() instead.
> 
> I need to re-check with a recent kernel build. I saw the message from
> setup_fadump and not the one from fadump_reserve_mem but not sure what
> the platform init code looked like in the kernel I tested with.

Indeed, I was missing the patch that changes the capitalization in
fadump_reserve_mem. In my kernel both messages are the same and the one
from fadump_reserve_mem is displayed.

Thanks

Michal
