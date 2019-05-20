Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88AF23067
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfETJdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:33:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48754 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfETJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:33:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6D9FC80457; Mon, 20 May 2019 11:33:03 +0200 (CEST)
Date:   Mon, 20 May 2019 11:33:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     wen.yang99@zte.com.cn, Markus.Elfring@web.de,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        nicolas.palix@imag.fr
Subject: Re: Coccinelle: semantic patch for missing of_node_put
Message-ID: <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
References: <201905171432571474636@zte.com.cn>
 <alpine.DEB.2.20.1905170912590.4014@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1905170912590.4014@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A semantic patch has no access to comments.  The only thing I can see to
> do is to use python to interact with some external tools.  For example,
> you could write some code to collect the comments in a file and the lines
> on which they occur, and then get the comment that most closely precedes
> the start of the function.

How dangerous is missing of_node_put? AFAICT it will only result into
very small, one-time memory leak, right?

Could we make sure these patches are _not_ going to stable? Leaking
few bytes once per boot is not really a serious bug.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
