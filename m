Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E35EBBE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 03:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfKACIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 22:08:18 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:39949 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:08:17 -0400
Received: by mail-yb1-f170.google.com with SMTP id d12so3309946ybn.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsFY1KIx9iJYif7vQxfbD15FpxrJSPWH13lYc5zzTiA=;
        b=nnIBH/N8r0bXFneNBS/XdONbwd5cpWNaSL+I/9jdd5Fmz60RYTHgZRqaUPxlkLfJF/
         fT6GoUIjbcZhvKEtfb1T5N8NEwHU+IiYHQ3C82VVD/k4ASdseeN5QRLFhb9CmK7yaztb
         l8Ox6EfAwEAeytcg+F2Eva4DhkSi98nCukrrUg3mYlwAEh1lRsw4xa2lar2+1mxpb52c
         W/Dm2m44xqX8rNbaKrzSkpjoauSA9/olWoWgM/M1PlrW3gt0vFsy0lTDtBMVcQxSGoko
         kl4I1jePNxSuX/D0RlPxYlv9XF/duXDAKtVGCoMRrUg9FKfem1SRsGMYr0PEcOLiw0eY
         jcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsFY1KIx9iJYif7vQxfbD15FpxrJSPWH13lYc5zzTiA=;
        b=tywmPe8ZrijwFtEII6Q/V4lwjjHzZk/VznBIJSOe7wbx8i2+N685O0jMfKQB0mXwIa
         zIDXkLW/uf/o4WVzeee8qYIYM9NB7MZImLVa8rnxr+TVZJ8fHGEFkMpryaclQySAJnvG
         VHbS416FA/HHSsH5/Qxee80qlK7JsCPzIAXbuRYpXJgVGdvZzYyWDWx4tp66pwhX7yho
         p1+JEgeCLzBJ9H9PHQmm94Tv3prk5V7luI+6nJtjqMx5AFftf98QxVd7iIprdfX204jm
         KWHFeQdOmqFrply902Pf9Moz/4kUvU3l77eABPEzYBtA2LsHU2lJ0v7kkYMYDpvSstDV
         5hWA==
X-Gm-Message-State: APjAAAXBcnxo1WvgdB0UqEQUyBNCBUT/VIsY14yNxuG1SVh3H+SvUZ19
        U4109Kzk4WpKOu2vC3W0WTWgOQ==
X-Google-Smtp-Source: APXvYqxC/QtBI+uTh4885NOyut2C808t2rcNQx3/HTaTMG6CKLO4pXNd03+eoSRaIX8JHlAqdEoyGw==
X-Received: by 2002:a25:ba01:: with SMTP id t1mr6972869ybg.309.1572574095898;
        Thu, 31 Oct 2019 19:08:15 -0700 (PDT)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id m5sm3762076ywj.27.2019.10.31.19.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 19:08:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/4] perf cs-etm: Correct synthesizing instruction samples
Date:   Fri,  1 Nov 2019 10:07:48 +0800
Message-Id: <20191101020750.29063-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101020750.29063-1-leo.yan@linaro.org>
References: <20191101020750.29063-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'etm->instructions_sample_period' is less than
'tidq->period_instructions', the function cs_etm__sample() cannot handle
this case properly with its logic.

Let's see below flow as an example:

- If we set itrace option '--itrace=i4', then function cs_etm__sample()
  has variables with initialized values:

  tidq->period_instructions = 0
  etm->instructions_sample_period = 4

- When the first packet is coming:

  packet->instr_count = 10; the number of instructions executed in this
  packet is 10, thus update period_instructions as below:

  tidq->period_instructions = 0 + 10 = 10
  instrs_over = 10 - 4 = 6
  offset = 10 - 6 - 1 = 3
  tidq->period_instructions = instrs_over = 6

- When the second packet is coming:

  packet->instr_count = 10; in the second pass, assume 10 instructions
  in the trace sample again:

  tidq->period_instructions = 6 + 10 = 16
  instrs_over = 16 - 4 = 12
  offset = 10 - 12 - 1 = -3  -> the negative value
  tidq->period_instructions = instrs_over = 12

So after handle these two packets, there have below issues:

The first issue is that cs_etm__instr_addr() returns the address within
the current trace sample of the instruction related to offset, so the
offset is supposed to be always unsigned value.  But in fact, function
cs_etm__sample() might calculate a negative offset value (in handling
the second packet, the offset is -3) and pass to cs_etm__instr_addr()
with u64 type with a big positive integer.

The second issue is it only synthesizes 2 samples for sample period = 4.
In theory, every packet has 10 instructions so the two packets have
total 20 instructions, 20 instructions should generate 5 samples
(4 x 5 = 20).  This is because cs_etm__sample() only calls once
cs_etm__synth_instruction_sample() to generate instruction sample per
range packet.

This patch fixes the logic in function cs_etm__sample(); the basic
idea is to divide into three parts for handling coming packet:

- The first part is for synthesizing the first instruction sample, it
  combines the instructions from the tail of previous packet and the
  instructions from the head of the new packet;
- The second part is to simply generate samples with sample period
  aligned;
- The third part is the tail of new packet, the rest instructions will
  be left to next time handling with sequential packet.

Suggested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 106 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8be6d010ae84..8e9eb7583bcd 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1360,23 +1360,103 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * TODO: allow period to be defined in cycles and clock time
 		 */
 
-		/* Get number of instructions executed after the sample point */
-		u64 instrs_over = tidq->period_instructions -
-			etm->instructions_sample_period;
+		/*
+		 * Below diagram is used to demonstrate the instruction samples
+		 * generation flows:
+		 *
+		 *    Instrs     Instrs       Instrs       Instrs
+		 *   Sample(n)  Sample(n+1)  Sample(n+2)  Sample(n+3)
+		 *    |            |            |            |
+		 *    V            V            V            V
+		 *   --------------------------------------------------
+		 *            ^                                  ^
+		 *            |                                  |
+		 *         Period                             Period
+		 *    instructions(Pi)                   instructions(Pi')
+		 *
+		 *            |                                  |
+		 *            \---------------- -----------------/
+		 *                             V
+		 *                      instrs_executed
+		 *
+		 * When the new instruction packet is coming, period
+		 * instructions (Pi) contains the the number of instructions
+		 * executed after the sample point(n).  So for the next sample
+		 * point(n+1), it is combined the two parts instructions, one
+		 * is the tail of the old packet and another is the head of
+		 * the new coming packet.  So we use 'head' variable to cauclate
+		 * the instruction numbers in the new packet for sample(n+1).
+		 *
+		 * For sample(n+2) and sample(n+3), they consume the instruction
+		 * for sample period, so we directly generate samples based on
+		 * the sampe period.
+		 *
+		 * After sample(n+3), there still leave some instructions which
+		 * will be used by later packet; so we use 'instrs_over' to
+		 * track the rest instruction number and its final value
+		 * presents the tail of the packet, it will be assigned to
+		 * 'tidq->period_instructions' for next round calculation.
+		 */
+		u64 head, offset = 0;
+		u64 addr;
 
 		/*
-		 * Calculate the address of the sampled instruction (-1 as
-		 * sample is reported as though instruction has just been
-		 * executed, but PC has not advanced to next instruction)
+		 * 'instrs_over' is the number of instructions executed after
+		 * sample points, initialise it to 'instrs_executed' and will
+		 * decrease it for consumed instructions in every synthesized
+		 * instruction sample.
 		 */
-		u64 offset = (instrs_executed - instrs_over - 1);
-		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
-					      tidq->packet, offset);
+		u64 instrs_over = instrs_executed;
 
-		ret = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr, etm->instructions_sample_period);
-		if (ret)
-			return ret;
+		/*
+		 * 'head' is the instructions number of the head in the new
+		 * packet, it combines with the tail of previous packet to
+		 * generate a sample.  So 'head' uses the sample period to
+		 * decrease the instruction number introduced by the previous
+		 * packet.
+		 */
+		head = etm->instructions_sample_period -
+				  (tidq->period_instructions - instrs_executed);
+
+		if (head) {
+			offset = head;
+
+			/*
+			 * Calculate the address of the sampled instruction (-1
+			 * as sample is reported as though instruction has just
+			 * been executed, but PC has not advanced to next
+			 * instruction)
+			 */
+			addr = cs_etm__instr_addr(etmq, trace_chan_id,
+						  tidq->packet, offset - 1);
+			ret = cs_etm__synth_instruction_sample(
+				etmq, tidq, addr,
+				etm->instructions_sample_period);
+			if (ret)
+				return ret;
+
+			instrs_over -= head;
+		}
+
+		while (instrs_over >= etm->instructions_sample_period) {
+			offset += etm->instructions_sample_period;
+
+			/*
+			 * Calculate the address of the sampled instruction (-1
+			 * as sample is reported as though instruction has just
+			 * been executed, but PC has not advanced to next
+			 * instruction)
+			 */
+			addr = cs_etm__instr_addr(etmq, trace_chan_id,
+						  tidq->packet, offset - 1);
+			ret = cs_etm__synth_instruction_sample(
+				etmq, tidq, addr,
+				etm->instructions_sample_period);
+			if (ret)
+				return ret;
+
+			instrs_over -= etm->instructions_sample_period;
+		}
 
 		/* Carry remaining instructions into next sample period */
 		tidq->period_instructions = instrs_over;
-- 
2.17.1

