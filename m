Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDB4B728
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfFSLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 07:35:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33280 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbfFSLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:35:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so9598077pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHo+CK98Hk560A324w9NgmPfYqiucAAoOc1YvZRRmoc=;
        b=OiuBJyYMUwp7Feymf81ldAOyO51jCbmcCR+ngPCLcmMfJHERBLuEK/NtPFeN8+K+6T
         5/0SjsluzJJsesg4+W5STJStN4hWNLIcBT1aCRImcHUGxT3RG/6WbQ5aLsJR13ptzBpD
         p+QEtCFBEOATUSVe2ryWCzsoIeDaI39Bm7GB0aMEfN6LG2nFoW2+vjpRABHRvUTCdlQy
         UYrE3MLG4Oosu0hnZIIBU8BwsjW479JrJxmnoQZ2dcvYeSFh2hoGcACQ4peHEKnfsiTW
         FXNHd+kydKJOwYyrxFX8yxTIV+2HiZ/7KSpYEGXw8jhg6+fMMEtFImqU237wWKj+1wQN
         N+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHo+CK98Hk560A324w9NgmPfYqiucAAoOc1YvZRRmoc=;
        b=ZFwC4UGTPNI2i1xsnkSCgZb13RqbWx27TstZiGQvSfq+l+vhST445VadyowacEoV8z
         tVv/GilAvCq/tv+60Bif25Fw9KTe5VpSqOmIWeTlbCCS2hKbkY/CNEGpHyfO+mvM5gTg
         zaP5ya1zVy+quPm3VLB7m3n4nUNPSz3EWtr9IoXODCxCOS6wKVczNAnxp2tsKtKabBKV
         Jo5V3K4fxtux0gIHLOFtMkHVKmTZAgmaUfyiJ1jKHz/tzMn6Sv73lvU50jIBGvOEsCG4
         h2XHVQEZlk8DsOHqzBztsDUgvCxmc6JzTs7lqOqnZLnK8ETUd3ZP0/5682UTALIxkmeF
         qJFw==
X-Gm-Message-State: APjAAAWiFQ00QaQjSq62Q7y7YXQREiH6aTfxzD9o/kVok7wEiC7YZQ72
        3lyzH6jg/957Wofx8sU5j0CkEg==
X-Google-Smtp-Source: APXvYqxDL5o/8GAGOXNmziNNKY5OxiV9QQF3uCMMooHoEQ3XZDdUhEVFVVkwYjmDlXX4/XN6VXw8eQ==
X-Received: by 2002:a63:6f47:: with SMTP id k68mr7245648pgc.327.1560944154053;
        Wed, 19 Jun 2019 04:35:54 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id d9sm19205662pgj.34.2019.06.19.04.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with has_target()
Date:   Wed, 19 Jun 2019 17:05:38 +0530
Message-Id: <0660b023a0d80c63ec7a1f7fcb692de9a9f4d604.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUFREQ_CONST_LOOPS was introduced in a very old commit from pre-2.6
kernel release commit 6a4a93f9c0d5 ("[CPUFREQ] Fix 'out of sync'
issue").

Probably the initial idea was to just avoid these checks for set_policy
type drivers and then things got changed over the years. And it is very
unclear why these checks are there at all.

Replace the CPUFREQ_CONST_LOOPS check with has_target(), which makes
more sense now.

Also remove () around freq comparison statement as they aren't required
and checkpatch also warns for them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54befd775bd6..e59194c2c613 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		 * which is not equal to what the cpufreq core thinks is
 		 * "old frequency".
 		 */
-		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-			if (policy->cur && (policy->cur != freqs->old)) {
-				pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
-					 freqs->old, policy->cur);
-				freqs->old = policy->cur;
-			}
+		if (has_target() && policy->cur && policy->cur != freqs->old) {
+			pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
+				 freqs->old, policy->cur);
+			freqs->old = policy->cur;
 		}
 
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
@@ -1618,8 +1616,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 	if (policy->fast_switch_enabled)
 		return ret_freq;
 
-	if (ret_freq && policy->cur &&
-		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
+	if (has_target() && ret_freq && policy->cur) {
 		/* verify no discrepancy between actual and
 					saved value exists */
 		if (unlikely(ret_freq != policy->cur)) {
-- 
2.21.0.rc0.269.g1a574e7a288b

