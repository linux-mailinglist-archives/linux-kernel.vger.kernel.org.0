Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383FDDE4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 08:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfJUGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 02:52:58 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33638 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfJUGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:52:58 -0400
X-IronPort-AV: E=Sophos;i="5.67,322,1566856800"; 
   d="scan'208";a="407139933"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 08:52:55 +0200
Date:   Mon, 21 Oct 2019 08:52:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
In-Reply-To: <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1910210850080.2959@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>  <20191019140719.2542-2-jbi.octave@gmail.com> <20191019142443.GH24678@kadam>  <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>  <20191019180514.GI24678@kadam>  <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
  <20191020191759.GJ24678@kadam> <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> btw2:
>
> I really dislike all the code inconsistencies and
> unnecessary code duplication with miscellaneous changes
> in the rtl staging drivers....
>
> Horrid stuff.

I'm not sure what you mean by "miscellaneous changes".  Do you mean that
all issues should be fixed for one file before moving on to another one?

Or that there are code clones, and all of the clones should be updated at
the same time?

julia
