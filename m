Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2B8A3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 19:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfHLRGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 13:06:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40506 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:06:23 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 981B9CECF3;
        Mon, 12 Aug 2019 19:15:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Remove redundant initializations
 to zero
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190807185849.253065-1-mka@chromium.org>
Date:   Mon, 12 Aug 2019 19:06:20 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BB6ADE9C-E280-4C03-8E42-E5F08B68A194@holtmann.org>
References: <20190807185849.253065-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> The qca_data structure is allocated with kzalloc() and hence
> zero-initialized. Remove a bunch of unnecessary explicit
> initializations of struct members to zero.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> just noticed that this patch fell through the cracks, resending a
> rebased version.
> 
> Changes in v2:
> - added 'Reviewed-by' tag from Balakrishna
> - rebased on bluetooth-next/master
> 
> drivers/bluetooth/hci_qca.c | 19 -------------------
> 1 file changed, 19 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

