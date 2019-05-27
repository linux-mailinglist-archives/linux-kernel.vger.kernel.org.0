Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA22B2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfE0LHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 07:07:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfE0LHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6XzHVCeWV5GGMtIuZ7rGtzSJEpSJMgHeuPmsEScvE9M=; b=ADsHua2m6BxeKzAKZh2L7vhgY
        /T2yU2PCzT2t9fGMPSHNjtQAmqHgp6ByjIYLPx2Zp4FyEimHSVDk+bUHwMZuMEpXnTtoXAQZJtGP7
        mRPdI0oOROlaN1WnpNRTJkMadv2wmtIBuxUSwujnK6nt0aY4ESn5mK+Z6mXMH0QLuC/9+3DTcs7dA
        uALv/+U4qH5BUVt9TlYdyP7U/bOd2YLoGDUXU29jId7Kt9H9cLox7yVl5p3aE92H5AciGV8aSu3/j
        aUl4wAVT1D9aau4QZCPvA0Ao/PFt268QNQExWhUUJVuePlFPDiCoeHabplO6AoLmraCt67hB7OShy
        gmJQM8nUQ==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061w-NP; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002cb-N2; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Joel Nider <joeln@il.ibm.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/5] Improvements to the documentation build system
Date:   Mon, 27 May 2019 08:07:36 -0300
Message-Id: <cover.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first three patches here address some issues with the script which
detects the requirements for running Sphinx, making it a smarter and
running it all the times, in order to allow recommending version
updates.

The 4th patch adds "-jauto" by default, if Sphinx version supports it
(e. g. version 1.7 or upper).

The final patch changes the recommendation to use at least Sphinx
version 1.7.9, as discussed at linux-doc ML.

Mauro Carvalho Chehab (5):
  scripts/sphinx-pre-install: make activate hint smarter
  scripts/sphinx-pre-install: get rid of RHEL7 explicity check
  scripts/sphinx-pre-install: always check if version is compatible with
    build
  docs: by default, build docs a lot faster with Sphinx >= 1.7
  docs: requirements.txt: recommend Sphinx 1.7.9

 Documentation/Makefile                |  7 +++
 Documentation/doc-guide/sphinx.rst    | 17 +++---
 Documentation/sphinx/requirements.txt |  4 +-
 scripts/sphinx-pre-install            | 75 +++++++++++++++------------
 4 files changed, 58 insertions(+), 45 deletions(-)

-- 
2.21.0


