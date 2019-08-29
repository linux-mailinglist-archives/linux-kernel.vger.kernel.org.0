Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9BA14EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfH2J3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 05:29:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52695 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2J3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:29:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id t17so2945152wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWSruavJBjctqtbTw7cZ481dDATOlMFYVx3PLqKt1xM=;
        b=WX2rpIUPb76YhLAsOh6Kt3XYL/PWARYUEhArNTNRjb53eIPadhFEr1MwpKWwJ4mMIv
         ej7YAxPccq60NUii+YcUtFQUL0q45Kjxou2ZO0Ezj15ePj2dcTEDE25E9cvoUOmbqf73
         pBGYD5E2sKnNUALnt6Umtf3dfNIwz1+uptbrwAMBr5uP7flQgd1Wvlfjvfo5muWx0lPq
         kpvOVH03EARECgwsFEHCwO0gF+n88utpGrLyB62CtRS8vJ4QUfFYKjuFM+kRHvRok1D8
         LsAAP3VYMqGDZm8A+yDl04VKbPprXkqpInGtXSGfsg//EPF68WA7fx+qFKlM5Nw99F2d
         rUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWSruavJBjctqtbTw7cZ481dDATOlMFYVx3PLqKt1xM=;
        b=NnkR+hpHJVtDFvRc2XC7uuX+dtmqNrbyjFX4BA7h+RbsWA7RsysPeL3APrRgJ4/2bo
         oNtlaH/onFRn/AYgBDve8TYpKpWYG+PzAJ+zyjLdED4vAA5ydxEKR8JgDMDRuLI+UjnM
         0BflIKbS+sIEe2qSD73pLEyNK8/IO3Qye8UeN6RBDL/PcdqfniW1FxDtRdSlETG/i9z3
         FcqGrLxE0gCwwH9XTpTBbpr1QhI/YkJ5bSXtAz2UV+4shEn+NTBTefvSjWcQDmMB3Jtc
         eY6Qh/+IOpy/zf+Y7wKNt2aK1J1KR+kp8iWl6IuijVDs3dWu+3zzQ+GB9WUJJ6B+vgad
         WgAg==
X-Gm-Message-State: APjAAAVYQ3oAoqBmg5VBaZAh2/Qqrb6xJNBj1ZaSdifDUlf3LWJU2tj0
        UiZ6zKfnkJLmYB7VsUEidx6SYeLb1MY=
X-Google-Smtp-Source: APXvYqzbuDdv93j0VoasfKOm4yenxKf2GCYq781Qe7sARneINrHtWSK8QRj3bqYgMvKJNlk82yWeiw==
X-Received: by 2002:a7b:c952:: with SMTP id i18mr10832609wml.44.1567070974469;
        Thu, 29 Aug 2019 02:29:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f197sm3609512wme.22.2019.08.29.02.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:29:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] misc: fastrpc: few fixes
Date:   Thu, 29 Aug 2019 10:29:21 +0100
Message-Id: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

More testing on fastprc revealed few memory leaks in driver
and few corner cases.
These patches are the fixes for those cases.
One patch from Jorge is to remove unsed definition.

co-authorship issue on
"misc: fastrpc: fix double refcounting on dmabuf"
patch has been resolved offline and decided to not
change anything.

Thanks,
srini

Changes since v1:
 - Updated change log to remove TEST tag.
 - no code changes.

Bjorn Andersson (2):
  misc: fastrpc: Reference count channel context
  misc: fastrpc: Don't reference rpmsg_device after remove

Jorge Ramirez-Ortiz (1):
  misc: fastrpc: remove unused definition

Srinivas Kandagatla (2):
  misc: fastrpc: fix double refcounting on dmabuf
  misc: fastrpc: free dma buf scatter list

 drivers/misc/fastrpc.c | 74 ++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

-- 
2.21.0

