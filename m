Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374A3B69F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfIRRxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 13:53:10 -0400
Received: from verein.lst.de ([213.95.11.211]:34950 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbfIRRxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:53:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D313368C65; Wed, 18 Sep 2019 19:53:03 +0200 (CEST)
Date:   Wed, 18 Sep 2019 19:53:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
Message-ID: <20190918175303.GA20353@lst.de>
References: <20190918164121.30006-1-Larry.Finger@lwfinger.net> <20190918164518.GA19222@lst.de> <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 12:49:56PM -0500, Larry Finger wrote:
> Is there approved way for pages to be set to be executable by an external 
> module that would not be a security issue?

There is approved way for modules to set kernel code executable,
because well they shouldn't.  And as stated many times we do not
add interfaces for things not in mainline to start with.  So as a first
step please submit your module for inclusion and then we can discuss
if it actually happens to be a valid use case or not, and how to best
accomodate it.
