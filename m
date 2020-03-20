Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D818DBA2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 00:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCTXQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 19:16:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:44078 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCTXQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:16:49 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1313A537;
        Fri, 20 Mar 2020 23:16:49 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:16:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] docs: locking: Fix a typo and drop :c:func:
Message-ID: <20200320171647.67470ec0@lwn.net>
In-Reply-To: <20200318174133.160206-1-swboyd@chromium.org>
References: <20200318174133.160206-1-swboyd@chromium.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 10:41:31 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Fix a typo in the hardirq section where we're missing a word and 
> then drop :c:func: markup throughout.
> 
> Changes from v1:
>  * New patch to drop :c:func:
> 
> Stephen Boyd (2):
>   docs: locking: Add 'need' to hardirq section
>   docs: locking: Drop :c:func: throughout
> 
>  Documentation/kernel-hacking/locking.rst | 176 +++++++++++------------
>  1 file changed, 88 insertions(+), 88 deletions(-)

Both patches applied, thanks.

jon
