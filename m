Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5130318C792
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 07:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCTGiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 02:38:54 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33632 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTGix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:38:53 -0400
Received: by mail-pj1-f67.google.com with SMTP id dw20so3117549pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRVhjjDD7XDl/ETxhVS+N5qQy7f2YR4UjmY+Va7NcIg=;
        b=k1jXwyAuASqdG4q2GMsWq8R3D3oD+CJtwwbeFsM3NNte3Tjo3tG5Fri927exJdRwAL
         Ucd1dVzBECsE31JCm+u6WELtE0af5EZDyXmEmwLTV+J2UvBNe47Ww+o2K/eXG6pypM83
         zkldNrNgDw8wplWNZKixLdMI15c0g/GPxxjyWwa/VxY/rEMRzqFx+fEKjup2+0g0cdYa
         8M/YadjWpEu5Bm+7PcGkV5I9QiMQUzDkB3KnOscWkQdVF7tQEubXcu4FhtqqjYbEAD2w
         Ip5tc0+5uOQcFmjwTov/u48CNTFF6npBneeL5Q9fX3HS+qPF82hpVWec7jf+ahf3GXOB
         6NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRVhjjDD7XDl/ETxhVS+N5qQy7f2YR4UjmY+Va7NcIg=;
        b=gmTHkOhVhWM3eFQTDihBWAzFeCe3DCsrC7Ws8t2iQC+6caIdugLiFeJycbR/INAmaz
         34M1j8VPe0Cxg/1Qp6ey1wZr3lUmpmpxcOXdkUluQgadWgWwQb+gCxz+E6RPX7O/tUMb
         BGKybMlHjtsnGtADbwbaYcfXPUoD0c1xaxtylxwBN9upI7P5W+suF0+8ashuvDW0ySip
         M6tNIVRWlrRQ8C/17s7Wh7LuoS0FBYOMzKTYybX1qYuwckBhgATN0k14BMNLvIKrZKVA
         b0YkDmrGi8UxqXDcsua4iEoU5j7G4DYAFbB2O339qHDSD7cfQbpbJPRi6M2Q2mqfcvAi
         5FMA==
X-Gm-Message-State: ANhLgQ1xOajGSLaeXpFWcSwiMp04WUGq7UWVe9pnNbljtTaEq4xfvQFn
        Q1Byc7R08IIYIHF3iKpwWfnKClhjfgHRKrST
X-Google-Smtp-Source: ADFU+vuAqL4vQjKPSkB3rW0832Dll8GemgDdGRZ6ZhihE6tUalFcheR5/sWW60aa9pISP4cH2vAnDg==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr7658748pje.123.1584686330284;
        Thu, 19 Mar 2020 23:38:50 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id y3sm4370901pfy.158.2020.03.19.23.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 23:38:49 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH v2 0/2] Feed current txrate information for mac80211
Date:   Fri, 20 Mar 2020 14:38:31 +0800
Message-Id: <20200320063833.1058-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fills the txrate, sgi, bandwidth information
in the sta_statistics function. Then the nl80211 commands
such as 'iw link' can show the correct txrate information.

v2: make the rtl8xxxu_desc_to_mcsrate() static


Chris Chiu (2):
  rtl8xxxu: add enumeration for channel bandwidth
  rtl8xxxu: Feed current txrate information for mac80211

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 21 ++++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 77 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.20.1

