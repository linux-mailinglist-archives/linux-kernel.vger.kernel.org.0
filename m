Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2924128A2B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 16:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLUP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 10:28:00 -0500
Received: from netrider.rowland.org ([192.131.102.5]:41583 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726716AbfLUP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 10:28:00 -0500
Received: (qmail 30523 invoked by uid 500); 21 Dec 2019 10:27:59 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Dec 2019 10:27:59 -0500
Date:   Sat, 21 Dec 2019 10:27:58 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] USB: EHCI: ehci-mv: make HSIC work
In-Reply-To: <20191221065008.266445-1-lkundrak@v3.sk>
Message-ID: <Pine.LNX.4.44L0.1912211027220.30361-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2019, Lubomir Rintel wrote:

> please have a look at the three patches chained to this message. They
> are independent of each other and can be applied iny any order.
> 
> My main objective was to make HSIC work on MMP3. The PHY patch is
> loosely related to that (there's no MMP3 HSIC PHY driver, but the NOP
> is sufficient). The last one is a cosmetic thing.
> 
> Compared to first submission, the patches are now submitted as series
> and the wording of the third one's commit message has been changed.

All three patches are okay with me.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

