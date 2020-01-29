Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA914D0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgA2TDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:03:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49812 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgA2TDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:03:40 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 31DB1CECC9;
        Wed, 29 Jan 2020 20:12:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] bluetooth: optimize barrier usage for Rmw atomics
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200129181041.24853-1-dave@stgolabs.net>
Date:   Wed, 29 Jan 2020 20:03:38 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Content-Transfer-Encoding: 7bit
Message-Id: <3824A860-1ACD-479C-A862-E1449D49BC05@holtmann.org>
References: <20200129181041.24853-1-dave@stgolabs.net>
To:     Davidlohr Bueso <dave@stgolabs.net>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

> Use smp_mb__before_atomic() instead of smp_mb() and avoid the
> unnecessary barrier for non LL/SC architectures, such as x86.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> net/bluetooth/hidp/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

