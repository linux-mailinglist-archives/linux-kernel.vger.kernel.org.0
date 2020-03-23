Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDC18FE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCWUSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 16:18:33 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35465 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:18:32 -0400
Received: by mail-il1-f193.google.com with SMTP id 7so1215146ill.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLK+0MXB1YCUxEYtc8f13Y1fsHrfKc3dAmXJsyrL2Do=;
        b=MGvfT/ZCDfekdgX8JfbS9dRhNv7TsWG45BVuA7cScrf/g2hAtpZMDVOH4JFd9FmJIz
         UNq2Ctb9kX0KkGRMqGdKuQLxEpr7eObJYYK7K8HYUH04od7/EUHF/Xkm1SJxcyvYr82x
         vZ44Kwvp1Zi49aSESmABiuDDl9lZXcwE13wak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLK+0MXB1YCUxEYtc8f13Y1fsHrfKc3dAmXJsyrL2Do=;
        b=XfhnuaC5Xepi+C1++71SBsMpdw5BrdBojhl6H8rsXg5OjJJYUlJulQeIKc71+rhaP8
         U8pwPaKr66jAuM/9BbtUIpGyzWqOtrQGh/5+NfD/1sgVEoPinC23kwU25vsnJjkH5v8E
         isRP9cDqSxK9Znhj39xIxrV5TIKoi9q0+xj/spfdmVul0YEdTlEIHVduN0E3OODjy3XH
         Grrhw4de3R8rzG1KYDCIW4jH4EyHn8IfDtQmvinOkrv3XLl4MeDZ5K27e1aOLjPvAJXW
         5oEvIVtbKewaW1PHD7TV6bM1cqJV24qv+nDsq3qgku4LUBX4/87YQZUUPuh+XGFGVzHj
         OJuA==
X-Gm-Message-State: ANhLgQ3RvhM1LepOkdqlu0g08hP4DiBVomdh52AqlKm7qebPkd5QgNmR
        Sle8qboF4MRtXpV4u2vp5qj1DA==
X-Google-Smtp-Source: ADFU+vu3Y3DQH33iLh270INKEB5slnS+0DWkO38NONLJhYtp9IFpWkBQ72+D2lCkujplpJK+kPlHeA==
X-Received: by 2002:a92:91da:: with SMTP id e87mr21546890ill.183.1584994711567;
        Mon, 23 Mar 2020 13:18:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a5sm3363352ioq.43.2020.03.23.13.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 13:18:30 -0700 (PDT)
Subject: Re: [PATCH v3] selftests: Fix seccomp to support relocatable build
 (O=objdir)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20200313212404.24552-1-skhan@linuxfoundation.org>
 <8736a8qz06.fsf@mpe.ellerman.id.au> <202003161404.934CCE0@keescook>
 <87h7yldohs.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eb90dd83-7988-b3ac-1ee6-bf16c0aacc10@linuxfoundation.org>
Date:   Mon, 23 Mar 2020 14:18:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87h7yldohs.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael and Kees,

On 3/18/20 9:15 PM, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
>> On Mon, Mar 16, 2020 at 11:12:57PM +1100, Michael Ellerman wrote:
>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>> Fix seccomp relocatable builds. This is a simple fix to use the right
>>>> lib.mk variable TEST_GEN_PROGS with dependency on kselftest_harness.h
>>>> header, and defining LDFLAGS for pthread lib.
>>>>
>>>> Removes custom clean rule which is no longer necessary with the use of
>>>> TEST_GEN_PROGS.
>>>>
>>>> Uses $(OUTPUT) defined in lib.mk to handle build relocation.
>>>>
>>>> The following use-cases work with this change:
>>>>
>>>> In seccomp directory:
>>>> make all and make clean
>>>>
>>>>  From top level from main Makefile:
>>>> make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
>>>>   CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>
>>>> Changes since v2:
>>>> -- Using TEST_GEN_PROGS is sufficient to generate objects.
>>>>     Addresses review comments from Kees Cook.
>>>>
>>>>   tools/testing/selftests/seccomp/Makefile | 18 ++++++++----------
>>>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
>>>> index 1760b3e39730..a0388fd2c3f2 100644
>>>> --- a/tools/testing/selftests/seccomp/Makefile
>>>> +++ b/tools/testing/selftests/seccomp/Makefile
>>>> @@ -1,17 +1,15 @@
>>>>   # SPDX-License-Identifier: GPL-2.0
>>>> -all:
>>>> -
>>>> -include ../lib.mk
>>>> +CFLAGS += -Wl,-no-as-needed -Wall
>>>> +LDFLAGS += -lpthread
>>>>   
>>>>   .PHONY: all clean
>>>>   
>>>> -BINARIES := seccomp_bpf seccomp_benchmark
>>>> -CFLAGS += -Wl,-no-as-needed -Wall
>>>> +include ../lib.mk
>>>> +
>>>> +# OUTPUT set by lib.mk
>>>> +TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
>>>>   
>>>> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
>>>> -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
>>>> +$(TEST_GEN_PROGS): ../kselftest_harness.h
>>>>   
>>>> -TEST_PROGS += $(BINARIES)
>>>> -EXTRA_CLEAN := $(BINARIES)
>>>> +all: $(TEST_GEN_PROGS)
>>>>   
>>>> -all: $(BINARIES)
>>>
>>>
>>> It shouldn't be that complicated. We just need to define TEST_GEN_PROGS
>>> before including lib.mk, and then add the dependency on the harness
>>> after we include lib.mk (so that TEST_GEN_PROGS has been updated to
>>> prefix $(OUTPUT)).
>>>
>>> eg:
>>>
>>>    # SPDX-License-Identifier: GPL-2.0
>>>    CFLAGS += -Wl,-no-as-needed -Wall
>>>    LDFLAGS += -lpthread
>>>    
>>>    TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
>>>    
>>>    include ../lib.mk
>>>    
>>>    $(TEST_GEN_PROGS): ../kselftest_harness.h
>>
>> Exactly. This (with an extra comment) is precisely what I suggested during
>> v2 review:
>> https://lore.kernel.org/lkml/202003041815.B8C73DEC@keescook/
> 
> Oh sorry, I missed that.

Sorry. I missed it as well.

> 
> OK so I think we know what the right solution is.
> 

I am picking this back up after time off.

The proposed change by you works for seccomp. There are at least 10+
tests that have dependencies on kselftest_harness.h and several that
have dependency on kselftest.h and kselftest_module.h

Enforcing this local header dependency in lib.mk makes sense so we
don't have to change the test make files.

Add dependency to libk.mk on local headers. This enforces the dependency
blindly even when a test doesn't include the file, with the benefit of a
simpler enforcement without requiring individual tests to have special
rule for it.

The following two changes work. You both have better make foo than
I do. Can you see any issues with this proposal? I can send patch
to do this, so we can do a larger test.

--------------------------------------------------------------
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3ed0134a764d..54caa9a4ec8a 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -137,7 +137,7 @@ endif
  # Selftest makefiles can override those targets by setting
  # OVERRIDE_TARGETS = 1.
  ifeq ($(OVERRIDE_TARGETS),)
-$(OUTPUT)/%:%.c
+$(OUTPUT)/%:%.c ../kselftest_harness.h ../kselftest.h
         $(LINK.c) $^ $(LDLIBS) -o $@

  $(OUTPUT)/%.o:%.S


diff --git a/tools/testing/selftests/seccomp/Makefile 
b/tools/testing/selftests/seccomp/Makefile
index a0388fd2c3f2..0ebfe8b0e147 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -2,14 +2,5 @@
  CFLAGS += -Wl,-no-as-needed -Wall
  LDFLAGS += -lpthread

-.PHONY: all clean
-
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
  include ../lib.mk
-
-# OUTPUT set by lib.mk
-TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
-
-$(TEST_GEN_PROGS): ../kselftest_harness.h
-
-all: $(TEST_GEN_PROGS)
-
--------------------------------------------------------------

thanks,
-- Shuah


