Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8C50D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 16:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfFXOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 10:05:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44829 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:05:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so12732093ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjx1On7f1VuMt9pjHPrhxleD/jqhPbFIKT7N3KSr3NM=;
        b=taqQtVSyBzuZ4c+2VF7FW4RLKaX/Cp/CaiXZ1tvthUGsTt/1mjyGJaT8LzDEYV+x+2
         ayswVg645HrxsJ54YVhWs92jFhvJTxTsIYHqJaHrFzOFaJLHdBXB0irvPVysbJXoWUAv
         Twn96UY1OHsftdpH95LB5pw/K7gynmkGD4Jvan0g4TZyjZmtz6UFua2/cxf9eBRfgiPs
         EY0NxGieJmyuSnMyQ1XYQboxwl/mV9SfVLJp5hFXfCLxrE4Mj8pLPh/LXeRgwtAacHw4
         ojdmCnGGPCTMUP/z8Sr+6cfNkQX2PuaF+wdsHgJtl5YNaG8m1JWG+keKmIqHuzTFEwcO
         xHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjx1On7f1VuMt9pjHPrhxleD/jqhPbFIKT7N3KSr3NM=;
        b=FP8/khCkUi6+T/vTQAQN+nO69PerLLaSk0RA+1est1h+xx7bVeNdsE9htXdQf67vvq
         NlIs6yw9yhWbfcoun/U1g+G96J69Lkt1ZUQHvdWrfArZM1/iql+XOKmk259u8YHKxfqQ
         oOWocf2gxiSRTj5LFxcwpLeq0mqcKm3htDySSxwhR/iXgDWzsHIVhP9bYMntiQMYe/xF
         cehIj015c/XbFU4NXepv8ZcgL/j7S2RAcK8xs+mB+LBQX0Duf3wYP5S5MgDwbCM4e3VI
         JX3o5OZqQzawkRr0G0NcXMbaQbkidPK40j3MkwnGrF4ltMnIm4PaI4vP4bARttW4KEwX
         0Mtg==
X-Gm-Message-State: APjAAAVngk/bnevLck/H/ZPj5Hu9AX+wQLWYebKaPy0aOdGOBlQ3MKqU
        8qvAecwW8YHTH3Ydu85WLZPojmt9oXHKsDK0y0mqAw==
X-Google-Smtp-Source: APXvYqy1v/JREDF0Z2UI1o9VWF2fFyKN2OstLEsW5Et4kEIc//QPnE+TIqkrxCyn741ldFWGAnTrC3kuxwBMW34Q+pA=
X-Received: by 2002:a2e:994:: with SMTP id 142mr8590901ljj.130.1561385129002;
 Mon, 24 Jun 2019 07:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <1560959396-13969-1-git-send-email-pbonzini@redhat.com>
 <87zhmcfo0w.fsf@vitty.brq.redhat.com> <8ab81435-d94a-1883-a7e0-e2eba6a1ba68@redhat.com>
In-Reply-To: <8ab81435-d94a-1883-a7e0-e2eba6a1ba68@redhat.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Mon, 24 Jun 2019 07:05:16 -0700
Message-ID: <CAAAPnDFJmjjzsELo68zvJY1n_g_WGfS73ZUA1NOVQniYyF5Zdw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: reorganize initial steps of vmx_set_nested_state
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:18 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/06/19 14:18, Vitaly Kuznetsov wrote:
> > There's also something wrong with the patch as it fails to apply because
> > of (not only?) whitespace issues or maybe I'm just applying it to the
> > wrong tree...
>
> Yes, there's a change to KVM_GET/SET_NESTED_STATE structs from Liran.
>
> Paolo

Below is a revised patch for vmx_set_nested_state_test based on your
changes.  If I applied your patch correctly I think they should look
something like this.  I don't have your changes to kvm_nested_state,
so those still have to be applied, but I think they are good
otherwise.

---
 .../kvm/x86_64/vmx_set_nested_state_test.c    | 59 ++++++++++---------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index 9d62e2c7e024..17cf72749ca8 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -113,25 +113,6 @@ void test_vmx_nested_state(struct kvm_vm *vm)
  state->format = 1;
  test_nested_state_expect_einval(vm, state);

- /*
- * We cannot virtualize anything if the guest does not have VMX
- * enabled.
- */
- set_default_vmx_state(state, state_sz);
- test_nested_state_expect_einval(vm, state);
-
- /*
- * We cannot virtualize anything if the guest does not have VMX
- * enabled.  We expect KVM_SET_NESTED_STATE to return 0 if vmxon_pa
- * is set to -1ull.
- */
- set_default_vmx_state(state, state_sz);
- state->vmx.vmxon_pa = -1ull;
- test_nested_state(vm, state);
-
- /* Enable VMX in the guest CPUID. */
- vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-
  /* It is invalid to have vmxon_pa == -1ull and SMM flags non-zero. */
  set_default_vmx_state(state, state_sz);
  state->vmx.vmxon_pa = -1ull;
@@ -139,19 +120,28 @@ void test_vmx_nested_state(struct kvm_vm *vm)
  test_nested_state_expect_einval(vm, state);

  /* It is invalid to have vmxon_pa == -1ull and vmcs_pa != -1ull. */
- set_default_vmx_state(state, state_sz);
- state->vmx.vmxon_pa = -1ull;
- state->vmx.vmcs_pa = 0;
+ state->vmx.smm.flags = 0;
  test_nested_state_expect_einval(vm, state);

  /*
- * Setting vmxon_pa == -1ull and vmcs_pa == -1ull exits early without
- * setting the nested state.
+ * It is invalid to have vmxon_pa == -1ull and have one or both of the
+ * flags KVM_STATE_NESTED_RUN_PENDING or KVM_STATE_NESTED_GUEST_MODE
+ * set.
  */
- set_default_vmx_state(state, state_sz);
- state->vmx.vmxon_pa = -1ull;
+ state->flags = KVM_STATE_NESTED_RUN_PENDING |
+        KVM_STATE_NESTED_GUEST_MODE;
  state->vmx.vmcs_pa = -1ull;
- test_nested_state(vm, state);
+ test_nested_state_expect_einval(vm, state);
+
+ /*
+ * We cannot virtualize anything if the guest does not have VMX
+ * enabled.
+ */
+ set_default_vmx_state(state, state_sz);
+ test_nested_state_expect_einval(vm, state);
+
+ /* Enable VMX in the guest CPUID. */
+ vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());

  /* It is invalid to have vmxon_pa set to a non-page aligned address. */
  set_default_vmx_state(state, state_sz);
@@ -195,11 +185,26 @@ void test_vmx_nested_state(struct kvm_vm *vm)
  state->vmx.vmcs_pa = 0;
  test_nested_state_expect_einval(vm, state);

+ /*
+ * It is invalid to not have the vmcs_pa set when the flag
+ * KVM_STATE_NESTED_EVMCS is not set.
+ */
+ set_default_vmx_state(state, state_sz);
+ state->vmx.vmcs_pa = -1ull;
+ state->flags = KVM_STATE_NESTED_GUEST_MODE  |
+ KVM_STATE_NESTED_RUN_PENDING;
+ test_nested_state_expect_einval(vm, state);
+
  /* The revision id for vmcs12 must be VMCS12_REVISION. */
  set_default_vmx_state(state, state_sz);
  set_revision_id_for_vmcs12(state, 0);
  test_nested_state_expect_einval(vm, state);

+ /* The KVM_STATE_NESTED_GUEST_MODE flag must be set */
+ set_default_vmx_state(state, state_sz);
+ state->flags = KVM_STATE_NESTED_EVMCS;
+ test_nested_state(vm, state);
+
  /*
  * Test that if we leave nesting the state reflects that when we get
  * it again.
--
