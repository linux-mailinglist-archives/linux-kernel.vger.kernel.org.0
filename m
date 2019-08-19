Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D691B61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 05:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfHSDLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 23:11:17 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52707 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfHSDLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 23:11:17 -0400
Received: by mail-wm1-f50.google.com with SMTP id o4so253759wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RJha3Yo7GCStE93FNehdCyr/T/tnZGchrgysL2zcQuo=;
        b=sCaxeaGMCfWKGOlBWWiwkYhA1djo4C9+YcnlPbxpOqYzvMy2JuzD8phP1mVifLQ/Qx
         iw91f6rWYyZuBiTT55Fc54hvZ5+xfLk/40vntjRO3pjie/Ca4p7bw9stm0vQ1njjFkom
         ORd0rCcAJaUJvFq2Pa2dak4GXjOmakUxIJBb6+n8N7BKNLprq/ZMxqB2BzOMX4XMHUkB
         yMNa//zdtPYYoa59D4c1isIjNRm5Yj4D0ZYUnRmYnpwJDhb6UHxrR3X7m/xj9ZcJkaz0
         t7cyZEBjrTMh5itrdMnwtAUQEC/rCsesBAcs59R6lGigYPAhklG+Ux1sdvZK0Zx5m1v0
         aUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RJha3Yo7GCStE93FNehdCyr/T/tnZGchrgysL2zcQuo=;
        b=nl+5gnyQCnAKVIW1pOUXtUvi0eacOGZIp5EzSuuayMIWyC0MhkF7UGvhnF7AeOUIW4
         /gJklOaVrXktoJSlBR8cbe4Y+0PsdwbfdJ8dYA6kVXlBCseNzqzKUCBQwMWLgOSF1gNk
         AYRdBm6igFej5+tc/MtvD5TrJg+dgVSAxLCwklW/NshwXf+X+zaCw+iajNeUXUbJvOuM
         nCgWAKVy4xvkWYrNdG2nZCWA/DQsVo0zmX4UiGWWw0vYqA4/8RrmDD0+E5Rn6odS9mWj
         /fbChS5ehlQXfrItpZ03G60GlTmAJfrQc77YUsC9+E/kpU4uf9sK678uKjO5Fk5eEu55
         HWpQ==
X-Gm-Message-State: APjAAAXXObSANgQWjVtR/eJlJsc16nHMtLKpSefMnWG05Kngb/NMwCHs
        8jVbrhI0fLkYbNNas+suZ1HxY5/R
X-Google-Smtp-Source: APXvYqwHSSl2UeZPDN7aV7mWn/7H8i6uTDW65PDSa332vuJ1RZMy/B5mXCdS00Lurl3USk9qNwmYTg==
X-Received: by 2002:a7b:c187:: with SMTP id y7mr17752421wmi.155.1566184275728;
        Sun, 18 Aug 2019 20:11:15 -0700 (PDT)
Received: from [192.168.1.20] (host109-153-59-46.range109-153.btcentralplus.com. [109.153.59.46])
        by smtp.googlemail.com with ESMTPSA id z12sm3039011wrt.92.2019.08.18.20.11.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 20:11:15 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
From:   Chris Clayton <chris2553@googlemail.com>
Subject: linux-5.3.0-rc5: new build warning
Message-ID: <a8cbf200-4550-c6a5-c732-91996d97617c@googlemail.com>
Date:   Mon, 19 Aug 2019 04:11:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just built 5.3.0-rc5 and a warning that I do not recall having seen before was emitted:

...
  HOSTCC  scripts/extract-cert
  HOSTCC   /mnt/kernel/linux/tools/objtool/fixdep.o
  HOSTLD  arch/x86/tools/relocs
  HOSTLD   /mnt/kernel/linux/tools/objtool/fixdep-in.o
  LINK     /mnt/kernel/linux/tools/objtool/fixdep
  CC       /mnt/kernel/linux/tools/objtool/builtin-check.o
  CC       /mnt/kernel/linux/tools/objtool/builtin-orc.o
  GEN      /mnt/kernel/linux/tools/objtool/arch/x86/lib/inat-tables.c
awk: arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
awk: arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape
sequence `\&' is not a known regexp operator
  CC       /mnt/kernel/linux/tools/objtool/exec-cmd.o
  CC       /mnt/kernel/linux/tools/objtool/check.o
  CC       /mnt/kernel/linux/tools/objtool/arch/x86/decode.o
  CC       /mnt/kernel/linux/tools/objtool/orc_gen.o
  CC       /mnt/kernel/linux/tools/objtool/help.o
  CC       /mnt/kernel/linux/tools/objtool/orc_dump.o
  CC       /mnt/kernel/linux/tools/objtool/pager.o
 ...


Happy to test the fix, but please cc me as I'm not subscribed

Chris
