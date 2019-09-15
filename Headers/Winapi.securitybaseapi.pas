unit Winapi.securitybaseapi;

{$MINENUMSIZE 4}

interface

uses
  Winapi.WinNt;

type
  // WinNt.9493
  TWellKnownSidType = (
    WinNullSid,
    WinWorldSid,
    WinLocalSid,
    WinCreatorOwnerSid,
    WinCreatorGroupSid,
    WinCreatorOwnerServerSid,
    WinCreatorGroupServerSid,
    WinNtAuthoritySid,
    WinDialupSid,
    WinNetworkSid,
    WinBatchSid,
    WinInteractiveSid,
    WinServiceSid,
    WinAnonymousSid,
    WinProxySid,
    WinEnterpriseControllersSid,
    WinSelfSid,
    WinAuthenticatedUserSid,
    WinRestrictedCodeSid,
    WinTerminalServerSid,
    WinRemoteLogonIdSid,
    WinLogonIdsSid,
    WinLocalSystemSid,
    WinLocalServiceSid,
    WinNetworkServiceSid,
    WinBuiltinDomainSid,
    WinBuiltinAdministratorsSid,
    WinBuiltinUsersSid,
    WinBuiltinGuestsSid,
    WinBuiltinPowerUsersSid,
    WinBuiltinAccountOperatorsSid,
    WinBuiltinSystemOperatorsSid,
    WinBuiltinPrintOperatorsSid,
    WinBuiltinBackupOperatorsSid,
    WinBuiltinReplicatorSid,
    WinBuiltinPreWindows2000CompatibleAccessSid,
    WinBuiltinRemoteDesktopUsersSid,
    WinBuiltinNetworkConfigurationOperatorsSid,
    WinAccountAdministratorSid,
    WinAccountGuestSid,
    WinAccountKrbtgtSid,
    WinAccountDomainAdminsSid,
    WinAccountDomainUsersSid,
    WinAccountDomainGuestsSid,
    WinAccountComputersSid,
    WinAccountControllersSid,
    WinAccountCertAdminsSid,
    WinAccountSchemaAdminsSid,
    WinAccountEnterpriseAdminsSid,
    WinAccountPolicyAdminsSid,
    WinAccountRasAndIasServersSid,
    WinNTLMAuthenticationSid,
    WinDigestAuthenticationSid,
    WinSChannelAuthenticationSid,
    WinThisOrganizationSid,
    WinOtherOrganizationSid,
    WinBuiltinIncomingForestTrustBuildersSid,
    WinBuiltinPerfMonitoringUsersSid,
    WinBuiltinPerfLoggingUsersSid,
    WinBuiltinAuthorizationAccessSid,
    WinBuiltinTerminalServerLicenseServersSid,
    WinBuiltinDCOMUsersSid,
    WinBuiltinIUsersSid,
    WinIUserSid,
    WinBuiltinCryptoOperatorsSid,
    WinUntrustedLabelSid,
    WinLowLabelSid,
    WinMediumLabelSid,
    WinHighLabelSid,
    WinSystemLabelSid,
    WinWriteRestrictedCodeSid,
    WinCreatorOwnerRightsSid,
    WinCacheablePrincipalsGroupSid,
    WinNonCacheablePrincipalsGroupSid,
    WinEnterpriseReadonlyControllersSid,
    WinAccountReadonlyControllersSid,
    WinBuiltinEventLogReadersGroup,
    WinNewEnterpriseReadonlyControllersSid,
    WinBuiltinCertSvcDComAccessGroup,
    WinMediumPlusLabelSid,
    WinLocalLogonSid,
    WinConsoleLogonSid,
    WinThisOrganizationCertificateSid,
    WinApplicationPackageAuthoritySid,
    WinBuiltinAnyPackageSid,
    WinCapabilityInternetClientSid,
    WinCapabilityInternetClientServerSid,
    WinCapabilityPrivateNetworkClientServerSid,
    WinCapabilityPicturesLibrarySid,
    WinCapabilityVideosLibrarySid,
    WinCapabilityMusicLibrarySid,
    WinCapabilityDocumentsLibrarySid,
    WinCapabilitySharedUserCertificatesSid,
    WinCapabilityEnterpriseAuthenticationSid,
    WinCapabilityRemovableStorageSid,
    WinBuiltinRDSRemoteAccessServersSid,
    WinBuiltinRDSEndpointServersSid,
    WinBuiltinRDSManagementServersSid,
    WinUserModeDriversSid,
    WinBuiltinHyperVAdminsSid,
    WinAccountCloneableControllersSid,
    WinBuiltinAccessControlAssistanceOperatorsSid,
    WinBuiltinRemoteManagementUsersSid,
    WinAuthenticationAuthorityAssertedSid,
    WinAuthenticationServiceAssertedSid,
    WinLocalAccountSid,
    WinLocalAccountAndAdministratorSid,
    WinAccountProtectedUsersSid,
    WinCapabilityAppointmentsSid,
    WinCapabilityContactsSid,
    WinAccountDefaultSystemManagedSid,
    WinBuiltinDefaultSystemManagedGroupSid,
    WinBuiltinStorageReplicaAdminsSid,
    WinAccountKeyAdminsSid,
    WinAccountEnterpriseKeyAdminsSid,
    WinAuthenticationKeyTrustSid,
    WinAuthenticationKeyPropertyMFASid,
    WinAuthenticationKeyPropertyAttestationSid,
    WinAuthenticationFreshKeyAuthSid,
    WinBuiltinDeviceOwnersSid
  );

// 658
function CreateWellKnownSid(WellKnownSidType: TWellKnownSidType;
  DomainSid: PSid; PSid: PSid; var cbSid: Cardinal): LongBool;
  stdcall; external advapi32;

implementation

end.
