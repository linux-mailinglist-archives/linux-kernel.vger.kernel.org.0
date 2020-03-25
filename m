Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339D51924E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 06:01:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53937 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:01:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id b12so1649129wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBTA3RwxD80D4wayjboyFPP8ij+Z0pvHkdG+FymQql0=;
        b=GitQOasxH6mJtq7RaZzPN46fEM2OSzFQbTUMZ7cr0z0LNUOeGp5rm1ecV91rpHcqsg
         7vO2By0dYLzTtazTFG/GaIO8m1G0CkbqKbjDHosrWje4ZvmIQVpQQKUHt0ayYQcL4nFN
         Z/0thXrorSs180vykAkW3c1WX7xZNLzaiNV6YOyWTR4G2UphPT63+dZheNiWp2PSwWD0
         Oo+eov5V/xvreDt0FWL044DwQ9iRpngHslAUInyRJuiTGvis/Ty3Rx0eamgjRKEJFNbs
         G80hC2SX7XzPGEzzrBvUR5aIk0ixO25h5du8Xpi8ELkHvOR05jc3ZtTofx8FW5lgKlCI
         ijUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nBTA3RwxD80D4wayjboyFPP8ij+Z0pvHkdG+FymQql0=;
        b=jUM2Bgs8DllVstaeZueCyw8lbjXviKoY3/ZGK//Ng7AIk4GQfUNQUhTW01A6I852x+
         4j8z5O3/Vmfu5zw6TijMX/1MYejo1UJvUhbJWRyDzuffEzHEfyDqAebB8HHLwtQf/cyk
         38QJzVtMQ8sjqc1vUYbF748/YhyWbGDYa6h45+AjPlH5jkPAp94CCuW/20oiJZAMoVGE
         T1sxSNCx6EuZVJEkh6DDL/rLgHm90JQUzwtexVrEAAjEKqQI+tW1vtUFTVLP6CQT7Z+x
         m401oTpN5qLdRMdef3lUm5QbsENh2de5WfFTxLB3uZ8fYEqq2skz3g34PCZ+nFC+aXrv
         gp8w==
X-Gm-Message-State: ANhLgQ1aWCr3MKGn6jSOncj5G1HewdQxU5clu+zTFVhXN3zmoYclvE+h
        OCccdSp3o4VkpxtVq0IrJQRr59vzRxw=
X-Google-Smtp-Source: ADFU+vvB50YV0n15Uw6f6FCLrfwveDe8phdHcXCDapcTs8/K7Tlg2LjrmyYO4knPgv+FoGgkdWzGyg==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr2701138wmh.126.1585130501687;
        Wed, 25 Mar 2020 03:01:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k9sm34489672wrd.74.2020.03.25.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:01:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] nvmem: use is_bin_visible callback
Date:   Wed, 25 Mar 2020 10:01:36 +0000
Message-Id: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As suggested I managed to use is_bin_visible for the existing code
and also added few more checks for callbacks before setting
permissions on the file. Which also means that Thunderbolt case
for write-only should be fixed automatically with this patch.

Changes since v1:
	- Updated permissions setup logic as suggested by Greg
	- Added checks for callbacks.

Thanks,
srini

Srinivas Kandagatla (2):
  nvmem: core: add root_only member to nvmem device struct
  nvmem: core: use is_bin_visible for permissions

 drivers/nvmem/core.c        |  1 +
 drivers/nvmem/nvmem-sysfs.c | 85 +++++++++++++------------------------
 drivers/nvmem/nvmem.h       |  1 +
 3 files changed, 31 insertions(+), 56 deletions(-)

-- 
2.21.0

