Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05373182293
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgCKTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:35:01 -0400
Received: from haggis.mythic-beasts.com ([46.235.224.141]:45905 "EHLO
        haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbgCKTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:35:01 -0400
Received: from [146.90.33.204] (port=54428 helo=slartibartfast.quignogs.org.uk)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jC6wY-0008RB-Ah; Wed, 11 Mar 2020 19:23:02 +0000
From:   peter@bikeshed.quignogs.org.uk
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: [PATCH 0/1] Format kerneldoc code snippets as literal block
Date:   Wed, 11 Mar 2020 19:22:55 +0000
Message-Id: <20200311192256.15911-1-peter@bikeshed.quignogs.org.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 50
X-Spam-Status: No, score=5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Lister <peter@bikeshed.quignogs.org.uk>

A minimal patch to better format a couple of kerneldoc code snippets as
literal blocks and so remove kernel doc build warnings.

Peter Lister (1):
  Added double colons and blank lines within kerneldoc to format code
    snippets as ReST literal blocks.

 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.24.1

