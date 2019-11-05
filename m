Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E43F024F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 17:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbfKEQI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 11:08:29 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60604 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390125AbfKEQI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:08:28 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 11:08:28 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id ABEED1A2075;
        Tue,  5 Nov 2019 16:59:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.14.106])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 8E05C1A205E;
        Tue,  5 Nov 2019 16:59:37 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Aleksandar Markovic <amarkovic@wavecomp.com>
Subject: [PATCH 0/3] docs: ioctl: Update ioctl-number.rst
Date:   Tue,  5 Nov 2019 16:59:18 +0100
Message-Id: <1572969561-17591-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This is my attempt to bring ioctl-number.rst more up to date.
Still work in progress. Will send v2 when I add more updates.

Aleksandar Markovic (3):
  docs: ioctl: Update ioctl-number.rst ioctl ranges table
  docs: ioctl: Update ioctl-number.rst ioctl ranges table preamble
  docs: ioctl: Update ioctl-number.rst 'last updated' date

 Documentation/ioctl/ioctl-number.rst | 59 +++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

-- 
2.7.4

