Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206562E5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2UVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:21:36 -0400
Received: from www17.your-server.de ([213.133.104.17]:55950 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2UVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:21:36 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54o-0005xn-VU
        for linux-kernel@vger.kernel.org; Wed, 29 May 2019 22:21:35 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54n-0006IJ-Lj
        for linux-kernel@vger.kernel.org; Wed, 29 May 2019 22:21:34 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Wed, 29 May 2019 22:21:32 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:21:32 +0200
Subject: Cocci spatch "pool_zalloc-simple" - v5.2-rc1
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25464/Wed May 29 09:59:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.

Found by coccinelle spatch "api/alloc/pool_zalloc-simple.cocci"

Run against version v5.2-rc1

P.S. If you find this email unwanted, set up a procmail rule junking on
the header:

X-Patch: Cocci
