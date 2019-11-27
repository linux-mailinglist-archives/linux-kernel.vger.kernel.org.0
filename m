Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C310B0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 15:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfK0OMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 09:12:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:42840 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0OMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:12:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 61FDE537;
        Wed, 27 Nov 2019 14:12:06 +0000 (UTC)
Date:   Wed, 27 Nov 2019 07:12:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: Update ko_KR translations
Message-ID: <20191127071205.723a33d4@lwn.net>
In-Reply-To: <20191126222144.GW2889@paulmck-ThinkPad-P72>
References: <20191121234125.28032-1-sj38.park@gmail.com>
        <20191126222144.GW2889@paulmck-ThinkPad-P72>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 14:21:44 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Nov 22, 2019 at 12:41:18AM +0100, SeongJae Park wrote:
> > This patchset contains updates of Korean translation documents and a fix
> > of original document.
> > 
> > First 4 patches update the Korean translation of memory-barriers.txt.
> > Fifth patch fixes a broken section reference in the original
> > memory-barriers.txt.
> > 
> > Sixth and seventh patches update the Korean translation of howto.rst.  
> 
> The sixth and seventh probably have some other more natural path,
> but I queued them.  Any chance of a Reviewed-by from one of our other
> Korean-language kernel hackers?

I applied the whole set to docs-next a few days ago...apologies if that's
not the way you wanted these handled.

jon
