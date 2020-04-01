Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7819AC24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgDAMzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:55:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732289AbgDAMzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:55:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA95CAE59;
        Wed,  1 Apr 2020 12:55:14 +0000 (UTC)
Date:   Wed, 1 Apr 2020 14:55:14 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
Subject: Re: [PATCH v2 01/10] objtool: Move header sync-check ealier in
 build
In-Reply-To: <315c119a-0986-a3a0-7243-5fe0dd9038ea@redhat.com>
Message-ID: <alpine.LSU.2.21.2004011454220.15809@pobox.suse.cz>
References: <20200327152847.15294-1-jthierry@redhat.com> <20200327152847.15294-2-jthierry@redhat.com> <alpine.LSU.2.21.2004011430120.15809@pobox.suse.cz> <315c119a-0986-a3a0-7243-5fe0dd9038ea@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Julien Thierry wrote:

> 
> 
> On 4/1/20 1:32 PM, Miroslav Benes wrote:
> > On Fri, 27 Mar 2020, Julien Thierry wrote:
> > 
> >> Currently, the check of tools files against kernel equivalent is only
> >> done after every object file has been built.
> > 
> >> This means one might fix
> >> build issues against outdated headers without seeing a warning about
> >> this.
> > 
> > Could you explain the above in more detail, please?
> > 
> 
> I must admit that this patch is more fixing the issues I've faced while
> working on the arm64 support and sharing some kernel headers from the
> arch/arm64 tree.
> 
> The annoying part was:
> - Have build errors in objtool
> - Fix them
> - Objtool build succeeds, but have warning about outdated headers
> - Update headers
> - New errors come up, potentially making obsolete the ealier fixes

Ah right, yes.
 
> So it's not really a "must have" change. But it's nice to have when bringing
> new kernel headers to objtool.

No, I think it is useful.

> I hope this makes things clearer.

Yes, it does.

Thanks
Miroslav
