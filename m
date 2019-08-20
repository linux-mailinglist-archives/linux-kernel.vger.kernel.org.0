Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109FC9635C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfHTO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbfHTO6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:55 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF4A22DA9;
        Tue, 20 Aug 2019 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566313134;
        bh=M4cs3bSdfhfXd7GpzQV3YWsrvS7svtFqiw0IIyIt1xY=;
        h=From:To:Cc:Subject:Date:From;
        b=K/4urqalbUo/xT1vLZzyWwcicLvoxgg5a2rsPf9Va97Bg2xctULSYcICrcAeOj9c9
         MBs1T/qJBpJFn+zmWSh7P2qJFVQOGY/qDJSxQuJdsjD7tflXJ9HCYR5WnEKcwH1YEB
         edaFIq1QXOiYnVijBoR//pjEfvbkphu7h534h9rg=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
        linux@armlinux.org.uk, frowand.list@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, daniel.thompson@linaro.org,
        linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCHv4 0/1] drivers/amba: add reset control to amba
Date:   Tue, 20 Aug 2019 09:58:33 -0500
Message-Id: <20190820145834.7301-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Even though this patch is a V4, I'm including more people in this review
cycle because I found that there was previous patch[1] that was discussed.

Thanks,
Dinh


[1] https://patchwork.kernel.org/patch/10845695/

Dinh Nguyen (1):
  drivers/amba: add reset control to amba bus probe

 drivers/amba/bus.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.20.0

