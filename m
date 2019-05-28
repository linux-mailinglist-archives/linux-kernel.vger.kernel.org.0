Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9B2CED7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 20:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfE1Soo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 14:44:44 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45123 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfE1Son (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:44:43 -0400
Received: by mail-pl1-f173.google.com with SMTP id a5so8688956pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DFjPQf88/WEdwbAZuIhMdfy4wl7j7rHm9z/e0KQ/ick=;
        b=M7uebHrMZD2HFYCwXvvZYPGRo6TZmmPcaT61c1V+suPKNemNiMOv3XkQNEEEpt6Chc
         eJmV8ECUTE/nN2/z+7ayAwjyab9hS2gqTwmwbAAsHRBRLncIXHaj69WqAnInVSjftf9k
         Fdw+bSlBm5idQeiAkvrhLLc3PHUusTXgewlqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DFjPQf88/WEdwbAZuIhMdfy4wl7j7rHm9z/e0KQ/ick=;
        b=WS5fKdBcLrXh/OCT2OycVeNoUHzFPVqq/mvNOtkjqCqOkIuT1k8n3wNNgnn01peOyK
         EhMHc1GWusizIVKcLa+wGwF3/qKWiWP7TqoeQyZrAv3ppEkh5ba+GdNVkQQdNooBlKRR
         OBYfxvJfWs60/V+4vzF6GViZgklJvtJlI65GFVFOqhPpMwZb+DPjDTU+k/sJgeq3Bch/
         p453594/1Z1E+rpFJCorYLqtjN90db4m/RXDdpfGW54leF2J8YQTsZpe4+2RerNohqMS
         zWWp5HfodWxiFmEVgOSPUa9+BXu0db9ZtwaSDCaEmqbgbIoX+83tzy4cb7XtUub/1rip
         aaUQ==
X-Gm-Message-State: APjAAAUXyyea3cqw2XRS7Gw6r4oWck3CzDn4YTQqHKzXXvlMU9gDyUAO
        M2caW3Xh6FOClMe2B2df9l5d/Q==
X-Google-Smtp-Source: APXvYqwK8CwFA8GFX8OZgMGUz/uu9etWgEoQtN2jsuFurBEAh1VqlXKuwiXif0AXzRc+yEI1bFtYaw==
X-Received: by 2002:a17:902:8209:: with SMTP id x9mr9499883pln.327.1559069082854;
        Tue, 28 May 2019 11:44:42 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id j72sm3534085pje.12.2019.05.28.11.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:44:42 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 0/1] Allow TX timestamp with UDP GSO
Date:   Tue, 28 May 2019 11:44:14 -0700
Message-Id: <20190528184415.16020-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.

Fred Klassen (1):
  net/udp_gso: Allow TX timestamp with UDP GSO

 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.11.0

