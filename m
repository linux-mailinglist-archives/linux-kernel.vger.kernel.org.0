Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8F12E02F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgAASrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 13:47:36 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:58996 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAASrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:47:36 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 160C92009CA;
        Wed,  1 Jan 2020 18:47:35 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A33AA20085; Wed,  1 Jan 2020 19:42:37 +0100 (CET)
Date:   Wed, 1 Jan 2020 19:42:37 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     youling 257 <youling257@gmail.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101184237.GA43049@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101104313.GA666771@light.dominikbrodowski.net>
 <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
 <20200101175931.GA183871@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101175931.GA183871@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 12:59:32PM -0500, Arvind Sankar wrote:
> On Wed, Jan 01, 2020 at 09:27:27PM +0800, youling 257 wrote:
> > Unfortunately, test this patch still no help, has system/bin/sh warning.
> > 
> 
> Just to confirm, the only change needed to make the warning go away is
> reverting the single commit 8243186f0cc7 ("fs: remove ksys_dup()")?

That's what he reported, yes.

Thanks,
	Dominik
