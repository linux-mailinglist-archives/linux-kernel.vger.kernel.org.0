Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1595B17397F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgB1OJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 09:09:31 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40636 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1OJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:09:30 -0500
Received: by mail-lf1-f48.google.com with SMTP id c23so2195961lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BGRhYUunws4pXu6R++Tvw3n0xSj2znFbq+SxOUkGyqA=;
        b=ku0TrqiNTt/Updmc22hFfGsFnmEkXnafAY6IK9IF/lxQTbChpHGpHGJeXAIUXcjz9f
         3bibBejKZgxdA2R6y5BmOFyjwCeC1LQrjXKlRR0EVtDKymHHKlP1hc/V64ZjuRDIGWgg
         0m32E031Mes4vpU8lwtDwdKy/1Cuz+PIX7fd7AObKfBzaGvvQo3oSfg2ZvuFhmL5tNT0
         SDVJHPzldDUhWwkXuXrGytsb0p+SByxOsc2kNNku3TcBpZO4128LYE5EpN7gyuI/HjNo
         a1FqRv8PilKjVGm/TjMlUBSlOHMUvQofdPJDFuSULEcd0Y5qjqrHT2Vb7kTaZUxFEy6M
         PX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BGRhYUunws4pXu6R++Tvw3n0xSj2znFbq+SxOUkGyqA=;
        b=uNRckHCZteNPSaGPPw48oQHBoWFXZQ5UW3TMncBYgvVY739XL2AuxzR9diP7jqLlDU
         aECmQtwRnmFesRTNufqCpKVtIcmKIZiARz/2Ca49yiTQ4j7yKx2HUPtBtbSnYGJ0ZxvH
         LjyyoWcUMudv0hczNEGv1PEbSLWs0xGkTyeX3SQ3LbytzgVBhE2oLuDKKDlnHEox+isq
         604NEhVzzwz+VAlaxJxtCDq57bpklqBOsq4FwNB4WayZvFpJSiyI67MQbI4yy44es5rD
         kyzajsGvbhlWKhqWjmYfRYuVpbn7SLW/0urCopNocM1IEVYybuxQIUoqk4Qj4+Sj/itW
         pEww==
X-Gm-Message-State: ANhLgQ0DKEQD6WLtfk12TaVzOckocXzcDh4cvXK8o8MBlrz9iGm09fPj
        Gh24lx67Mq9mmEoWGxrSYbzg+ZLCBGg=
X-Google-Smtp-Source: ADFU+vvU3JDWmreoR+lLENn7LyX/SZLQgxYyjTHcZMkqilomsb4FiZ+siroa9Pq1k4tsahpukBvOmg==
X-Received: by 2002:a05:6512:6c5:: with SMTP id u5mr2774555lff.130.1582898968554;
        Fri, 28 Feb 2020 06:09:28 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id n13sm5773869lji.91.2020.02.28.06.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:09:27 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:09:25 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
Subject: [GIT PULL] TEE shared memory cleanup for v5.7
Message-ID: <20200228140925.GA12393@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these cleanup patches for shared memory in the TEE subsystem.

Thanks,
Jens


The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-cleanup-for-5.7

for you to fetch changes up to 758ecf13a41a9dc4f019c1381566132ef46c08ee:

  tee: tee_shm_op_mmap(): use TEE_SHM_USER_MAPPED (2020-02-28 13:37:42 +0100)

----------------------------------------------------------------
Cleanup shared memory handing in TEE subsystem
The highlights are:
- Removing redundant or unused fields in struct tee_shm
- Only assign userspace shm IDs for shared memory objects originating from
  user space

----------------------------------------------------------------
Jens Wiklander (5):
      tee: remove linked list of struct tee_shm
      tee: remove unused tee_shm_priv_alloc()
      tee: don't assign shm id for private shms
      tee: remove redundant teedev in struct tee_shm
      tee: tee_shm_op_mmap(): use TEE_SHM_USER_MAPPED

 drivers/tee/tee_core.c    |  1 -
 drivers/tee/tee_private.h |  3 +-
 drivers/tee/tee_shm.c     | 85 +++++++++++++----------------------------------
 include/linux/tee_drv.h   | 19 +----------
 4 files changed, 27 insertions(+), 81 deletions(-)
