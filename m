Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0078DFC5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 13:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 07:01:30 -0500
Received: from n7.nabble.com ([162.253.133.57]:52477 "EHLO n7.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfKNMB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:01:29 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2019 07:01:29 EST
Received: from n7.nabble.com (localhost [127.0.0.1])
        by n7.nabble.com (Postfix) with ESMTP id 29692114A61F9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:00:20 -0700 (MST)
Date:   Thu, 14 Nov 2019 05:00:20 -0700 (MST)
From:   Bruno GNUser <kernel@dantas.airpost.net>
To:     linux-kernel@vger.kernel.org
Message-ID: <1573732820166-0.post@n7.nabble.com>
Subject: how to disable the button kernel module?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I realize that /button/ is a kernel built-in and therefore cannot be disabled
via the /blacklist=<module_name>/ boot parameter. So I thought I'd try
/initcall_blacklist=<function>/ but I cannot find an obvious module
initialization function in button.c

Please, how would one disable the /button/ module? Either using the
/initcall_blacklist=foo/ or some other method is fine, as long as it does
not involve recompiling the kernel. 

Thanks,
Bruno GNUser



--
Sent from: http://linux-kernel.2935.n7.nabble.com/
