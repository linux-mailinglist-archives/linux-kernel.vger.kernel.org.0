Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFD191758
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCXRQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:16:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45807 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgCXRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so17811537wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hlu4/oEcjKLMa/XrI/z+9UQig2Q9LWUkvi9OsZuTRM=;
        b=Pfac01fnHKOubQZOVU0c/FgeUmsYFNzcBQQm0Mcu+0N/F0VJPqUGpuYiIUDxuYqibO
         QpWKi5OZAsvT4pJgvtnjVmt+PAKcwXxwjLjYgLFnCHTKSEhL2l3YudebqwObiSqXnVEJ
         VFaNOPo0FXTLIAKy64yB8b59X8wMvIzCKiysXo6tnc8DLHaMhPkscI7wEiKuwpen9LPd
         6S0QvDoKnPKFN21estcQyAzTKP7Q8rs1ATBujk4bvG7nMznJ7vjWqDZxKdeoULOcXwHB
         0GosJyhL8M2RuktddE2Z2B3a+N2S8I0Z4pRgdo70qlhDtPwWi2nwoOi6L/xjsk2cUd6a
         kx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hlu4/oEcjKLMa/XrI/z+9UQig2Q9LWUkvi9OsZuTRM=;
        b=lxXtz0+5JxiHRA0mc4uQcKK8ZkBMb6k/Iz27yf09XxlLlkbQe2WQC+j2jOHsxTGPjk
         1fBaUn4cyFUv2MnsowpuYfDxWgYfnqC384u9mx8cTaB4kUufB6+OAtNMPFIiUS0D2eie
         ed3Z5aGRlNStQHd3GiRBgaZA5Bfeev//vkY/iMi3pWSWesUvQypbKPm0SdxZVbuX8f5u
         y6UJYanNtdCbivdYI6SDyunLBgpB0zr3r2dXw+5o+CHTcD2qV/dqb8gRx0qBc/28oAoz
         P2S7gsWWB78imID7fPRT0Jd/WmfNKVGjB8ziYXRosIYvlm7tIlYhOujpiqvfnWOSkNLh
         I5+w==
X-Gm-Message-State: ANhLgQ3/Ym5lHFVmh7zzBCQts0uG9gCtDnuq4apDR2XcoGbnB42EvAT+
        oXqh5OcmX9VTSVeCZzLFXbiSDkpT8gM=
X-Google-Smtp-Source: ADFU+vtMPj/Ovo1j7SSP+rO5P4Dxmw4215jBDom0SNj7MRaynzDYsfYJK5BUlxopYZRLifvPxWL9/w==
X-Received: by 2002:adf:d849:: with SMTP id k9mr8050287wrl.108.1585070173882;
        Tue, 24 Mar 2020 10:16:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m11sm5269514wmf.9.2020.03.24.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 10:16:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: use is_bin_visible callback
Date:   Tue, 24 Mar 2020 17:15:57 +0000
Message-Id: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As suggested I managed to use is_bin_visible for the existing code and
one cleanup for using device_register/unregister directly instead of splitting.

Note: this does not add any new functionality, its just a cleanup

Thanks,
srini

Srinivas Kandagatla (3):
  nvmem: core: use device_register and device_unregister
  nvmem: core: add root_only member to nvmem device struct
  nvmem: core: use is_bin_visible for permissions

 drivers/nvmem/core.c        |  8 ++--
 drivers/nvmem/nvmem-sysfs.c | 74 +++++++++----------------------------
 drivers/nvmem/nvmem.h       |  1 +
 3 files changed, 22 insertions(+), 61 deletions(-)

-- 
2.21.0

