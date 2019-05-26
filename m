Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51BD2A984
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfEZL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 07:59:46 -0400
Received: from www17.your-server.de ([213.133.104.17]:49680 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfEZL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 07:59:45 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hUrZG-0001xz-9D
        for linux-kernel@vger.kernel.org; Sun, 26 May 2019 13:43:58 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hUrZE-0007Y6-WD
        for linux-kernel@vger.kernel.org; Sun, 26 May 2019 13:43:58 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Sun, 26 May 2019 13:43:56 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Sun, 26 May 2019 13:43:56 +0200
Message-Id: <E1hUrZE-0007Y6-WD@sslproxy01.your-server.de>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25461/Sun May 26 09:57:08 2019)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From thomas@m3y3r.de Sun May 26 00:14:21 2019
Subject: Cocci spatch "vma_pages" - v5.2-rc1
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1558822461331-726613767-0-diffsplit-thomas@m3y3r.de>

Use vma_pages function on vma object instead of explicit computation.

Found by coccinelle spatch "api/vma_pages.cocci"

Run against version v5.2-rc1

P.S. If you find this email unwanted, set up a procmail rule junking on
the header:

X-Patch: Cocci
