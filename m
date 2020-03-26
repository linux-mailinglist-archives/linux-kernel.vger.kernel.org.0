Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03B194752
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgCZTRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:17:13 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:34699 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:17:13 -0400
Received: from [87.115.226.141] (port=49586 helo=slartibartfast.quignogs.org.uk)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jHY04-00037G-J0; Thu, 26 Mar 2020 19:17:08 +0000
From:   peter@bikeshed.quignogs.org.uk
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: [PATCH v2 0/1] Compactly make code examples into literal blocks
Date:   Thu, 26 Mar 2020 19:16:27 +0000
Message-Id: <20200326191628.10052-1-peter@bikeshed.quignogs.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311133027.2c77f348@lwn.net>
References: <20200311133027.2c77f348@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 50
X-Spam-Status: No, score=5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Lister <peter@bikeshed.quignogs.org.uk>

In a previous patch, I fixed a couple of doc build warnings due to a
section heading "Example:" which didn't have the intended effect of
inserting a heading and literal quoting the following code snippet. I
added an explicit double colon to fix warnings and produce nice ReST.

Jon suggested that I could have used a minimal form "Example::".
Unfortunately not - kernel-doc munges the output so that the formatted
output ends up as a stray colon and no literal block.

Looking around in the source tree, it seems that parameter definitions
can be more complex than the original authors of kernel-doc allowed
for. Return values often need lists and examples often should be
literal blocks. Many comments in the source are "ASCII formatted" but
kernel-doc can make a mess of them and generate doc build warnings
along the way.

It seems useful to support some terse idioms which serve as compact
source annotation and also generate well formed ReST.

Here is a first try to let a heading directly introduce a literal
block - the "Example::" form for code snippets and an update to
platform.c to use it, just as Jon suggested.

Peter Lister (1):
  Provide a compact idiom to add code examples in kerneldoc comments.

 drivers/base/platform.c |  4 ++--
 scripts/kernel-doc      | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.25.1

