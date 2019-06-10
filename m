Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D33AEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 08:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfFJGGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 02:06:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43594 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387718AbfFJGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:06:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so4622549pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 23:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Dkvj991Uhw/1cfRgxPNcyrHB69xx77ySHEyTXjhqvA=;
        b=JivEgBVuc6FZ4RjN29MeUE/bi4q5QoB1acpQCvG8UpXZhGQxck6vFiqw3+HjTh4Z5W
         2K4vQW/5irgR3BnFrr6hbyNMNs+TGlC5gFHh39gF46VAA6T3UWprM0IpMfaexBbj7klS
         C0Urd0dp0FU36novirPjriUnM1bK4c4qYvHL5ciE28lX6N/I6tkzuWewsiYx41IgwElK
         8EN8i0ved+yvkXSHOyHWnRxljY31ztw1L4wSWA9XJg4P1lxb+WrzDxCzsVGJ9b6EpCpr
         lNF96CTDQxEDstXRPOrYiz/mixGYEg9zIzZHwEFO467O4vSldUCZJuNfgCWnHkneFL4s
         oaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Dkvj991Uhw/1cfRgxPNcyrHB69xx77ySHEyTXjhqvA=;
        b=Mi93uUw/OmIYWiAEKXjjUy3kKCYX4Vr+UHFv1o4putZWSHZ2ds+hiXUOeOXOw/spgN
         kPcsRV3pptkY0u9dQPrSzf5bwrbxzaQSB2MCKSTmT8U0Hbf1kZ2IMNU9sC4x1YZ608h0
         J++wC+2YEle5oVTeFsoJplV/UWApcWO8amY0znXMWbrKpg5USmdxVc6m7lj8M3k4ZYaB
         kzpyaovgG56WSg6seHjZwvZrJis+N9rMhZ8aXO2xNNOArzuX3lTfdYeczf17Ot3Drnbk
         9Hqi0Dq22G6FCwVvRG4kybKdytlQhyCTr2FpXQPG/JQP2ZNWLIIXdG/GkLGaW2mls7OM
         g54w==
X-Gm-Message-State: APjAAAVGkRJJSbdBlPDg9UCebFFs83DjDeMeFwRXd/jDJ2aqzkQy7rpj
        PU42YoYhJ8u3+Kk1fNueW6rOrw==
X-Google-Smtp-Source: APXvYqwLbTkJ83xIZQSN0X41sV2Qx5mmIUMQI8suaFwh1ovaQIunxZGLx5yEKCwIgFShFJqoprwhXg==
X-Received: by 2002:a62:2643:: with SMTP id m64mr70607053pfm.46.1560146800022;
        Sun, 09 Jun 2019 23:06:40 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id 26sm9290214pfi.147.2019.06.09.23.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 23:06:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] KVM: arm64: Implement vq_present() as a macro
Date:   Mon, 10 Jun 2019 11:36:33 +0530
Message-Id: <7c2590c4d8cc95cd40bbb05c0d0c5e2b0735a16b.1560145715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is a one-liner and doesn't really need to be function and
should be rather implemented as a macro.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- The previous implementation was fixing a compilation error that
  occurred only with old compilers (from 2015) due to a bug in the
  compiler itself.

- Dave suggested to rather implement this as a macro which made more
  sense.

 arch/arm64/kvm/guest.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3ae2f82fca46..a429ed36a6a0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -207,13 +207,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
-
-static bool vq_present(
-	const u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
-	unsigned int vq)
-{
-	return (*vqs)[vq_word(vq)] & vq_mask(vq);
-}
+#define vq_present(vqs, vq) ((*(vqs))[vq_word(vq)] & vq_mask(vq))
 
 static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
-- 
2.21.0.rc0.269.g1a574e7a288b

