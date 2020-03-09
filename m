Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790C017EBC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 23:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCIWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 18:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIWMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:12:33 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F5B24655;
        Mon,  9 Mar 2020 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583791953;
        bh=QEVIOTTGFengVBGIhcnZ/0ApXq8GfPuUZGdR/tCXeRY=;
        h=From:To:Cc:Subject:Date:From;
        b=bpbppBxNSUgInxz9YBIANVOaRz8t8G3yi73EGdNjue14Tcm4NmfT2Noz6o2p8Fms7
         PZEWRx3jDt+AoTToWOlcyTpDP13JxScrekrNN6GPdXDCtInfIdYNNTzkztGVHoLq4q
         od+cfso3hqbV8Jv69dTcE2Fp+2KfrMpB0/GP1J/k=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/2] clk qcom rpmh fixes
Date:   Mon,  9 Mar 2020 15:12:30 -0700
Message-Id: <20200309221232.145630-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had to read this driver today so I'm reworking it a 
little to ease readability. Based upon patches I've applied
to clk-qcom in clk.git

Stephen Boyd (2):
  clk: qcom: rpmh: Simplify clk_rpmh_bcm_send_cmd()
  clk: qcom: rpmh: Drop unnecessary semicolons

 drivers/clk/qcom/clk-rpmh.c | 41 ++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 23 deletions(-)


base-commit: cd5d5d8dec5e08e3e6ded9fa8366750a203b1d2a
-- 
Sent by a computer, using git, on the internet

