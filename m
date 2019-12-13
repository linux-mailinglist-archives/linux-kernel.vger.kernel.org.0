Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8450F11EC25
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 21:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLMUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 15:52:24 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:37891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:52:24 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MKd92-1iRUrq0e6u-00L10R; Fri, 13 Dec 2019 21:52:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 04/24] xtensa: ISS: avoid struct timeval
Date:   Fri, 13 Dec 2019 21:52:09 +0100
Message-Id: <20191213205221.3787308-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bon56UreV7ovrfKYpDHiL+f5Nx8t/BUmHyHC4ZWrp+337QR6/Oz
 yoHrf8bFVdBTm9Bp70qtT3uw7YkdpJ1O1sZaXMcTsuhFb80yjFDETofLv7guWHf8SfX/SWi
 7JtWqYDaB0F5EaXcZI7HYZKjKpI+VowaUgzdonJn2Ui6S8CD1Y+WjW+Wxq+qIFFqG2qZxFj
 DXk2Na2Jtl9aRnJx8qqpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:riv8b/vecL0=:+5F8OSMdE+Zx+eykCFEhxO
 sXEloGk35kuwMQ5iC/TYfbSAB9sznLnwNrJXrWj7Jk5OzpKPT8u0ngy1jeraukSYsbRn0MMWK
 knR/CwJOpAFdJ2jBM7/cPpQoJZ9FE0LVEt4nDrJtlj//JFJmEhycdtBa966T40yleoVKHS0gL
 WgsAnqopPgNtPuRUjMSSgizIw+/EvEa9NAbNL/8trmoyMkvAq1CuclnjBcezPPwXSdUwu+NHP
 Sl3OWXCGrpLo0M0XOh7qnPS71vZO+yv0H+fo7tb69naKhHJkJKrbfqbYJ9oc+n4K/qyZbvcE7
 237XU3QGoEQpSZmZsrZ4EiKudYtVipeMWxioOXuJr79Yvj249PXkrguIB0ixqifO1ibZRmdep
 SCjTdh5p0KtkMzpk8Lir2TjUSDKfT9CkU7vHDFOD9em1mhiDSpZb1AES9bCzYxoQKBrFgZo4/
 jsPLa+68w1XWS7kA1wOQZPAL61WrExikywTtsIH/g8WgBPG8Ruf8LMzWAmIO0WkYGANY4RXou
 qVOpwgkMRk2ICN4YXEQfRtUSh6JzB1x5rvU7aCGqnAynLrXepMcoaNqY2CyFh1RMy44xlG0of
 MJ5REbfwjWCRJuMnRTRk+j07qpGttYFTFRIxoM1SXZWyjgbVLS2iCLgHLglHC/EYjgTwARfHw
 H6wm/l1zWg4hJAB8GsG7Wk1LtL6KpAwJTkICE6JP9XOFRLELnHx3ivbuLW/rJmioKskrTGg1G
 EVWZfk7TxgGxu+B9CQ7s6gKbol+raNHwF6PBaPNM4HJ7YmAENLbZ0msg1x1DwtHrac69rYXsm
 Xn52pa6o2p14CdsOaj4VasNPaKIq/glJOv4vosws5YLCcACgZLVwOOxnXomzDp00KqQXxlRH0
 nsPGvv9AxjwGIPgElCtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct timeval' will get removed from the kernel, change the one
user in arch/xtensa to avoid referencing it, by using a fixed-length
array instead.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/platforms/iss/include/platform/simcall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/include/platform/simcall.h b/arch/xtensa/platforms/iss/include/platform/simcall.h
index 2ba45858e50a..4e2a48380dbf 100644
--- a/arch/xtensa/platforms/iss/include/platform/simcall.h
+++ b/arch/xtensa/platforms/iss/include/platform/simcall.h
@@ -113,9 +113,9 @@ static inline int simc_write(int fd, const void *buf, size_t count)
 
 static inline int simc_poll(int fd)
 {
-	struct timeval tv = { .tv_sec = 0, .tv_usec = 0 };
+	long timeval[2] = { 0, 0 };
 
-	return __simc(SYS_select_one, fd, XTISS_SELECT_ONE_READ, (int)&tv);
+	return __simc(SYS_select_one, fd, XTISS_SELECT_ONE_READ, (int)&timeval);
 }
 
 static inline int simc_lseek(int fd, uint32_t off, int whence)
-- 
2.20.0

