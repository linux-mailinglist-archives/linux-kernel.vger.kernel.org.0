Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8AB2341
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390390AbfIMPYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 11:24:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:46516 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388354AbfIMPYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:24:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 08:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179706190"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.26])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2019 08:24:16 -0700
Date:   Fri, 13 Sep 2019 23:28:20 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     "Spassov, Stanislav" <stanspas@amazon.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a
 device
Message-ID: <20190913152818.GA688@gao-cwp>
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
 <2c0ad3bf96551ea6e96e812229507221b76876c6.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c0ad3bf96551ea6e96e812229507221b76876c6.camel@amazon.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 10:02:24AM +0000, Spassov, Stanislav wrote:
>On Thu, Dec 13, 2018 at 07:54, Chao Gao wrote:
>>On Thu, Dec 13, 2018 at 12:54:52AM -0700, Jan Beulich wrote:
>>>>>> On 13.12.18 at 04:46, <chao.gao@intel.com> wrote:
>>>> On Wed, Dec 12, 2018 at 08:21:39AM -0700, Jan Beulich wrote:
>>>>>>>> On 12.12.18 at 16:18, <chao.gao@intel.com> wrote:
>>>>>> On Wed, Dec 12, 2018 at 01:51:01AM -0700, Jan Beulich wrote:
>>>>>>>>>> On 12.12.18 at 08:06, <chao.gao@intel.com> wrote:
>>>>>>>> On Wed, Dec 05, 2018 at 09:01:33AM -0500, Boris Ostrovsky wrote:
>>>>>>>>>On 12/5/18 4:32 AM, Roger Pau Monn� wrote:
>>>>>>>>>> On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
>>>>>>>>>>> I find some pass-thru devices don't work any more across guest reboot.
>>>>>>>>>>> Assigning it to another guest also meets the same issue. And the only
>>>>>>>>>>> way to make it work again is un-binding and binding it to pciback.
>>>>>>>>>>> Someone reported this issue one year ago [1]. More detail also can be
>>>>>>>>>>> found in [2].
>>>>>>>>>>>
>>>>>>>>>>> The root-cause is Xen's internal MSI-X state isn't reset properly
>>>>>>>>>>> during reboot or re-assignment. In the above case, Xen set maskall bit
>>>>>>>>>>> to mask all MSI interrupts after it detected a potential security
>>>>>>>>>>> issue. Even after device reset, Xen didn't reset its internal maskall
>>>>>>>>>>> bit. As a result, maskall bit would be set again in next write to
>>>>>>>>>>> MSI-X message control register.
>>>>>>>>>>>
>>>>>>>>>>> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
>>>>>>>>>>> internal state of a device, we employ it to fix this issue rather than
>>>>>>>>>>> introducing another dedicated sub-hypercall.
>>>>>>>>>>>
>>>>>>>>>>> Note that PHYSDEVOPS_release_msix() will fail if the mapping between
>>>>>>>>>>> the device's msix and pirq has been created. This limitation prevents
>>>>>>>>>>> us calling this function when detaching a device from a guest during
>>>>>>>>>>> guest shutdown. Thus it is called right before calling
>>>>>>>>>>> PHYSDEVOPS_prepare_msix().
>>>>>>>>>> s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also drop the
>>>>>>>>>> () at the end of the hypercall name since it's not a function.
>>>>>>>>>>
>>>>>>>>>> I'm also wondering why the release can't be done when the device is
>>>>>>>>>> detached from the guest (or the guest has been shut down). This makes
>>>>>>>>>> me worry about the raciness of the attach/detach procedure: if there's
>>>>>>>>>> a state where pciback assumes the device has been detached from the
>>>>>>>>>> guest, but there are still pirqs bound, an attempt to attach to
>>>>>>>>>> another guest in such state will fail.
>>>>>>>>>
>>>>>>>>>I wonder whether this additional reset functionality could be done out
>>>>>>>>>of xen_pcibk_xenbus_remove(). We first do a (best effort) device reset
>>>>>>>>>and then do the extra things that are not properly done there.
>>>>>>>> 
>>>>>>>> No. It cannot be done in xen_pcibk_xenbus_remove() without modifying
>>>>>>>> the handler of PHYSDEVOP_release_msix. To do a successful Xen internal
>>>>>>>> MSI-X state reset, PHYSDEVOP_{release, prepare}_msix should be finished
>>>>>>>> without error. But ATM, xen expects that no msi is bound to pirq when
>>>>>>>> doing PHYSDEVOP_release_msix. Otherwise it fails with error code -EBUSY.
>>>>>>>> However, the expectation isn't guaranteed in xen_pcibk_xenbus_remove().
>>>>>>>> In some cases, if qemu fails to unmap MSIs, MSIs are unmapped by Xen
>>>>>>>> at last minute, which happens after device reset in 
>>>>>>>> xen_pcibk_xenbus_remove().
>>>>>>>
>>>>>>>But that may need taking care of: I don't think it is a good idea to have
>>>>>>>anything left from the prior owning domain when the device gets reset.
>>>>>>>I.e. left over IRQ bindings should perhaps be forcibly cleared before
>>>>>>>invoking the reset;
>>>>>> 
>>>>>> Agree. How about pciback to track the established IRQ bindings? Then
>>>>>> pciback can clear irq binding before invoking the reset.
>>>>>
>>>>>How would pciback even know of those mappings, when it's qemu
>>>>>who establishes (and manages) them?
>>>> 
>>>> I meant to expose some interfaces from pciback. And pciback serves
>>>> as the proxy of IRQ (un)binding APIs.
>>>
>>>If at all possible we should avoid having to change more parties (qemu,
>>>libxc, kernel, hypervisor) than really necessary. Remember that such
>>>a bug fix may want backporting, and making sure affected people have
>>>all relevant components updated is increasingly difficult with their
>>>number growing.
>>>
>>>>>>>in fact I'd expect this to happen in the course of
>>>>>>>domain destruction, and I'd expect the device reset to come after the
>>>>>>>domain was cleaned up. Perhaps simply an ordering issue in the tool
>>>>>>>stack?
>>>>>> 
>>>>>> I don't think reversing the sequences of device reset and domain
>>>>>> destruction would be simple. Furthermore, during device hot-unplug,
>>>>>> device reset is done when the owner is alive. So if we use domain
>>>>>> destruction to enforce all irq binding cleared, in theory, it won't be
>>>>>> applicable to hot-unplug case (if qemu's hot-unplug logic is
>>>>>> compromised).
>>>>>
>>>>>Even in the hot-unplug case the tool stack could issue unbind
>>>>>requests, behind the back of the possibly compromised qemu,
>>>>>once neither the guest nor qemu have access to the device
>>>>>anymore.
>>>> 
>>>> But currently, tool stack doesn't know the remaining IRQ bindings.
>>>> If tool stack can maintaine IRQ binding information of a pass-thru
>>>> device (stored in Xenstore?), we can come up with a clean solution
>>>> without modifying linux kernel and Xen.
>>>
>>>If there's no way for the tool stack to either find out the bindings
>>>or "blindly" issue unbind requests (accepting them to fail), then a
>>>"wildcard" unbind operation may want adding. Or, perhaps even
>>>better, XEN_DOMCTL_deassign_device could unbind anything left
>>>in place for the specified device.
>>
>>Good idea. I will take this advice.
>>
>>Thanks
>>Chao
>
>I am having the same issue, and cannot find a fix in either xen-pciback or the Xen codebase.
>Was a solution ever pushed as a result of this thread?
>

I submitted patches [1] to Xen community. But I didn't get it merged.
We made a change in device driver to disable MSI-X during guest OS
shutdown to mitigate the issue. But when guest or qemu was crashed, we
encountered this issue again. I have no plan to get back to these
patches. But if you want to fix the issue completely along what the
patches below did, please go ahead.

[1]: https://lists.xenproject.org/archives/html/xen-devel/2019-01/msg01227.html

Thanks
Chao
