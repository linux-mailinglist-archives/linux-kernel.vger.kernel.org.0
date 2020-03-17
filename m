Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED381187702
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgCQApU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 20:45:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53784 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgCQApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:45:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D46C72711FF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] fixes to the hypervisor ubd thread
Date:   Mon, 16 Mar 2020 20:45:05 -0400
Message-Id: <20200317004507.1513370-1-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While debugging a somewhat related issue, I ran into two issues I
believe can cause the hypervisor to write garbage to the pipe.

This was find by visual inspection and is only slightly tested.  It
seems to partially some the problems my test case shows.

Please, let me know what you think

Gabriel Krisman Bertazi (2):
  um: ubd: Prevent buffer overrun on command completion
  um: ubd: Retry buffer read on any kind of error

 arch/um/drivers/ubd_kern.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.25.0

