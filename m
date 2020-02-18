Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76D162151
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgBRHFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 02:05:17 -0500
Received: from n7.nabble.com ([162.253.133.57]:64303 "EHLO n7.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgBRHFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:05:17 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 02:05:17 EST
Received: from n7.nabble.com (localhost [127.0.0.1])
        by n7.nabble.com (Postfix) with ESMTP id B326213C78940
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 23:56:04 -0700 (MST)
Date:   Mon, 17 Feb 2020 23:56:04 -0700 (MST)
From:   "mac.lu" <mac.lu@mediatek.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <1582008964730-0.post@n7.nabble.com>
Subject: NVMEM usage consult for device information
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Mediatek chip have some SOC configurations and specific data which would be
delivered to kernel by DTB.
So we want to implement a new NVMEM driver to retrieve these data for use by
the NVMEM Framework.
Do you agree with the usage for our application? 


Thanks
Mac



--
Sent from: http://linux-kernel.2935.n7.nabble.com/
