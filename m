Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7A230C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfETJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:52:40 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44073
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfETJwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:52:39 -0400
X-IronPort-AV: E=Sophos;i="5.60,491,1549926000"; 
   d="scan'208";a="306577805"
Received: from unknown (HELO hadrien) ([163.173.90.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 11:52:37 +0200
Date:   Mon, 20 May 2019 11:52:37 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Pavel Machek <pavel@ucw.cz>
cc:     Julia Lawall <julia.lawall@lip6.fr>, wen.yang99@zte.com.cn,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, sashal@kernel.org
Subject: Re: Coccinelle: semantic patch for missing of_node_put
In-Reply-To: <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
Message-ID: <alpine.DEB.2.21.1905201152040.2543@hadrien>
References: <201905171432571474636@zte.com.cn> <alpine.DEB.2.20.1905170912590.4014@hadrien> <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2019, Pavel Machek wrote:

> Hi!
>
> > A semantic patch has no access to comments.  The only thing I can see to
> > do is to use python to interact with some external tools.  For example,
> > you could write some code to collect the comments in a file and the lines
> > on which they occur, and then get the comment that most closely precedes
> > the start of the function.
>
> How dangerous is missing of_node_put? AFAICT it will only result into
> very small, one-time memory leak, right?
>
> Could we make sure these patches are _not_ going to stable? Leaking
> few bytes once per boot is not really a serious bug.

Sasha,

Probably patches that add only of_node_put should not be auto selected for
stable.

julia
