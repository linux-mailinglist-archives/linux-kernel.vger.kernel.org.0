Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D0BEBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 07:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392270AbfIZFaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 01:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388384AbfIZFaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:30:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289192146E;
        Thu, 26 Sep 2019 05:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569475801;
        bh=ih6FlBjGy8NvLVT5ABx1cYC1s8sHdn6Wkvf3RuY0i1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=054SUC9HpC/tYrn5c51FO5ks1yDgps8WdbO8lJMd/ugcQ877/HJ8aXWFSDjLz1btx
         +NuKazreoHFXhF/j/xWNqEnuyKniyjfEOOvvNCv++tWqLOAKtIsbFpbFb0nmdgF/mK
         qIQ3yqLRWwJBp3xCsEUTd1iuoz8DfP1xnDFMf4IA=
Date:   Thu, 26 Sep 2019 07:29:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, arnd@arndb.de, michal.simek@xilinx.com
Subject: Re: [RFC PATCHv2 1/3] dt-bindings: misc: Add dt bindings for flex
 noc Performance Monitor
Message-ID: <20190926052959.GA1562021@kroah.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:46:24AM +0530, Shubhrajyoti Datta wrote:
> Add dt bindings for flexnoc Performance Monitor.
> The flexnoc counters for read and write response and requests are
> supported.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../devicetree/bindings/misc/xlnx,flexnoc.txt      | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt

<snip>

Why are these "RFC"?

I guess you don't want them merged because you are not thinking that
they are good enough?  What needs to be done on them that you are
sending them out now?

greg k-h
