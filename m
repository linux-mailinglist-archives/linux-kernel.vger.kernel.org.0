Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98611771EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgCCJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:05:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgCCJFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:05:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4BF205ED;
        Tue,  3 Mar 2020 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583226347;
        bh=TKcNPx/l7ueoekrbOCO8dWLW98I9RoqjIf66pJRPwDU=;
        h=From:To:Cc:Subject:Date:From;
        b=hDqdfOA4iGzCKITn98eo9LL1iQY3+EFBiRj8yCOehAPrfAj+VfaD/v3PXw16lhcYq
         aKLJi/NWvQLmBlDzQhd/ANjY8rVeYJknOLFs6DG8WnRZEdFa8VXPczviV0WP1aZz0W
         HWLvZuxsuSYs1YrHK+d8lo6sPi5KXHY9fCnLhMQI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 0/1] Documentation: bootconfig: Documentaiton updates
Date:   Tue,  3 Mar 2020 18:05:42 +0900
Message-Id: <158322634266.31847.8245359938993378502.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 4th version of the documentation update.
This removes O= option from example. (This feature will be
implemented in another series.)

Thank you,

---

Masami Hiramatsu (1):
      Documentation: bootconfig: Update boot configuration documentation


 Documentation/admin-guide/bootconfig.rst |  181 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 117 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
