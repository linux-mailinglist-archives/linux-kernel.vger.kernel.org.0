Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5024F2BB73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfE0UlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 16:41:12 -0400
Received: from www17.your-server.de ([213.133.104.17]:53750 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0UlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:41:12 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hVMQg-0006wD-Gk
        for linux-kernel@vger.kernel.org; Mon, 27 May 2019 22:41:10 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hVMQf-000233-8N
        for linux-kernel@vger.kernel.org; Mon, 27 May 2019 22:41:10 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Mon, 27 May 2019 22:41:08 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Mon, 27 May 2019 22:41:08 +0200
Subject: Cocci spatch "of_table" - v5.2-rc1
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1558989631144-20791398-0-diffsplit-thomas@m3y3r.de>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25462/Mon May 27 09:58:16 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure (of/i2c/platform)_device_id tables are NULL terminated.

Found by coccinelle spatch "misc/of_table.cocci"

Run against version v5.2-rc1

P.S. If you find this email unwanted, set up a procmail rule junking on
the header:

X-Patch: Cocci
