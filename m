Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB85A4475
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHaMbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 08:31:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59131 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfHaMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 08:31:51 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8DE34CECF0;
        Sat, 31 Aug 2019 14:40:36 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] Bluetooth: btrtl: Remove trailing newline from calls
 to rtl_dev macros
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190831084611.GA10415@laptop-alex>
Date:   Sat, 31 Aug 2019 14:31:50 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F5DA09D5-F93C-46F3-8999-9D49078CF0F3@holtmann.org>
References: <20190831084611.GA10415@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> These printing macros already add a trailing newline, so drop these
> unnecessary additional newlines.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btrtl.c | 56 +++++++++++++++++++--------------------
> 1 file changed, 28 insertions(+), 28 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

